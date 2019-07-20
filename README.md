# amavisd-new

A mail filtering container image, based on alpine, running the amavisd-new
daemon for use via TCP port in mail servers. It interfaces with spamassassin
libraries, clamav daemon (seperate container) and the razor and pyzor tools.

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
