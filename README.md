# amavisd-new

A mail filtering container image, based on alpine, running the amavisd-new
daemon for use via TCP port in mail servers. It interfaces with spamassassin
libraries, clamav daemon (seperate container) and the razor tool.

Note that unzip, unxz, gunzip and bunzip2 are provided via busybox. Spamassassin
will prefer 7zr for zip files. Some older compressions like freeze, arj, lz4 and
ace are not included as they are unlikely to be used for spam and viruses today
and just increase the attack surface, as these tools aren't maintained anymore.

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
