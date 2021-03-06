FROM alpine:3.14

ENV POSTFIX_HOSTNAME postfix

COPY src /usr/local/bin

RUN apk upgrade --no-cache && \
    apk add --no-cache amavis cabextract p7zip patch perl-mail-spf perl-dbd-mysql razor spamassassin tzdata unrar && \
    # initialize spamassassin database
    sa-update -v && \
    chown -R amavis:amavis /etc/mail/spamassassin /var/lib/spamassassin && \
    # configure amavisd
    mv /usr/sbin/amavisd.conf /etc/amavisd.conf && \
    patch /etc/amavisd.conf /usr/local/bin/amavisd.conf.patch && \
    echo "1;" > /etc/amavisd-local.conf && \
    chmod o+r /etc/amavisd.conf && \
    rm /usr/local/bin/*.patch /etc/*.orig && \
    apk del --no-cache patch

WORKDIR /var/amavis
USER amavis:amavis

# Configure Razor
RUN razor-admin -create -d && \
    sed -i -r 's/^(logfile[^=]*=).*$/\1 \/dev\/stdout/g' \
        /var/amavis/.razor/razor-agent.conf && \
    razor-admin -register

EXPOSE 10024/tcp
VOLUME /etc/mail/spamassassin /var/amavis /var/lib/spamassassin /tmp

CMD start.sh
HEALTHCHECK CMD health.sh
