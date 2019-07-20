#!/bin/sh

if [ "$(echo | nc localhost 10024)" = '220 [127.0.0.1] ESMTP amavisd-new service ready' ]; then
	echo "extended hello successful"
else
	echo "extended hello failed"
	exit 1
fi
