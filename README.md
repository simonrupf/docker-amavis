# amavis

A mail filtering container image, based on alpine, running the amavis daemon for
use via TCP port in mail servers. It interfaces with spamassassin libraries,
clamav daemon (in a seperate container) and the razor tool.

Note that unzip, unxz, gunzip and bunzip2 are provided via busybox. Spamassassin
will prefer 7zr for zip files. Some older compressions like freeze, arj, lz4 and
ace are not included as they are unlikely to be used for spam and viruses today
and just increase the attack surface, as these tools aren't maintained anymore.

A MySQL connector is included, in case your mail server uses a MySQL/MariaDB
database backend for local domain lookups.

## Environment variables

- `POSTFIX_IP`: postfix server to forward clean mail to, needs to listen on port
  `10025/tcp`
- `TZ`: timezone used for logging, defaults to UTC

## Persistent volumes

- `/etc/amavisd-local.conf`: for additional configurations - owner 0, group 101, mode 0640
- `/var/amavis/db`: databases - owner 100, group 101, mode 0750
- `/var/amavis/home`: amavis working directory - owner 100, group 101, mode 0750
- `/var/amavis/quarantine`: quarantined mail - owner 100, group 101, mode 0750
- `/var/amavis/var`: spamassassin working directory - owner 100, group 101, mode 0750

## Network ports

- `10024/tcp`

This service expects to forward clean mail to a postfix server at `POSTFIX_IP`
on port `10025/tcp` and needs a clamav daemon with resolvable hostname `clamd`
listening on port `3310/tcp`.

## Usage

```shell
make run
```

## Stop

```shell
make clean
```

## Build

```shell
make build
```

## Build & run

```shell
make
```

## Debug image contents

```shell
make debug
```
