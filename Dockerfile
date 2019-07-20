FROM alpine:3.10

COPY src /usr/local/bin

RUN apk add --no-cache amavisd-new razor perl-mail-spf spamassassin p7zip cabextract unrar && \
    sed -i -r 's/^[^\$]*(\$myhostname[^=]*=).*$/\1 `hostname -d`;\n\@inet_acl \= qw\( 0\/0 \);\npush \@mynetworks, qw\(172\.17\/16\);/g' /etc/amavisd.conf && \
    # initialize spamassassin database
    sa-update -v && \
    chown -R amavis:amavis /etc/mail/spamassassin && \
    # patch to support newer spamassassin rules
    patch /usr/sbin/amavisd /usr/local/bin/*.patch && \
    rm /usr/local/bin/*.patch

WORKDIR /var/amavis
USER amavis:amavis

# Configure Razor
RUN razor-admin -create && \
    sed -i -r 's/^(logfile[^=]*=).*$/\1 \/dev\/stdout/g' \
        /var/amavis/.razor/razor-agent.conf && \
    razor-admin -register

EXPOSE 10024/tcp
VOLUME /var/amavis /var/lib/spamassassin /run /tmp

CMD start.sh
HEALTHCHECK --start-period=350s CMD health.sh
