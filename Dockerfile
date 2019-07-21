FROM alpine:3.10

COPY src /usr/local/bin

RUN apk add --no-cache amavisd-new razor perl-mail-spf spamassassin p7zip cabextract unrar && \
    # initialize spamassassin database
    sa-update -v && \
    chown -R amavis:amavis /etc/mail/spamassassin && \
    # patch to support newer spamassassin rules
    patch /usr/sbin/amavisd /usr/local/bin/*amavisd.patch && \
    # configure amavisd
    patch /etc/amavisd.conf /usr/local/bin/*amavisd.conf.patch && \
    chmod o+r /etc/amavisd.conf && \
    rm /usr/local/bin/*.patch

WORKDIR /var/amavis
USER amavis:amavis

# Configure Razor
RUN razor-admin -create && \
    sed -i -r 's/^(logfile[^=]*=).*$/\1 \/dev\/stdout/g' \
        /var/amavis/.razor/razor-agent.conf && \
    razor-admin -register

EXPOSE 10024/tcp
VOLUME /var/amavis /var/lib/spamassassin /tmp

CMD start.sh
HEALTHCHECK CMD health.sh
