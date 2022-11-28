# amavis change log

## 0.3.9
update to Alpine 3.17 / openssl 3.0.7

## 0.3.8
update to Alpine 3.16 / openssl 1.1.1o

## 0.3.7
update to Alpine 3.15 / amavis 2.12.2 / openssl 1.1.1l
removal of unrar, see https://gitlab.alpinelinux.org/alpine/aports/-/merge_requests/26234

## 0.3.6
update to Alpine 3.14 / spamassassin 3.4.6

## 0.3.5
update to Alpine 3.13 / amavis 2.12.1 / openssl 1.1.1k / handling removal of BerkeleyDB in Alpine

## 0.3.4
update to Alpine 3.12 / spamassassin 3.4.5 / package renaming and dependencies

## 0.3.3
update to openssl 1.1.1g

## 0.3.2
in an IPv6 enabled docker environment, localhost will resolve to ::1 (IPv6), but amavis only listens on 0.0.0.0 (IPv4)

## 0.3.1
update to Alpine 3.11 / amavis 2.12 / spamassassin 3.4.3 / razor 2.85 - removing the now merged amavis patch

## 0.3.0
add timezone support for logging, improve documentation

## 0.2.1
using more robust, IP based configuration

## 0.2.0
allow local configuration overrides, add MySQL/MariaDB lookup support, made
postfix destination MTA configurable via environment variable

## 0.1.1
ensuring sa-update can write to databases, avoiding creation of razor log file

## 0.1.0
initial packaging, patching alpines amavisd to support newer spamassassin rules

