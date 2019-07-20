#!/bin/sh

case "$(echo | nc localhost 10024)" in
  "220"*" ready"*)  echo "extended hello successful" ;;
  *)                echo "extended hello failed" && exit 1 ;;
esac
