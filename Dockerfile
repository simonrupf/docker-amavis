FROM alpine:3.20

LABEL org.opencontainers.image.authors="Simon Rupf <simon@rupf.net>" \
      org.opencontainers.image.source=https://github.com/simonrupf/docker-amavis \
      org.opencontainers.image.version="${VERSION}"

ENV POSTFIX_HOSTNAME postfix

COPY src /usr/local/bin

RUN apk upgrade --no-cache && \
    apk add --no-cache amavis cabextract 7zip patch perl-dbd-mysql \
        perl-io-socket-ssl perl-mail-spf razor spamassassin tzdata && \
    # initialize spamassassin database
    sa-update -v && \
    chown -R amavis:amavis /etc/mail/spamassassin /var/lib/spamassassin && \
    # configure amavisd
    patch /etc/amavisd.conf /usr/local/bin/amavisd.conf.patch && \
    echo "1;" > /etc/amavisd-local.conf && \
    chmod o+r /etc/amavisd.conf && \
    rm /usr/local/bin/*.patch && \
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
