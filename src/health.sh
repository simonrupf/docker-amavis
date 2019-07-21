#!/bin/sh

case "$(echo | nc localhost 10024)" in
	"220"*" ready"*)
		echo "amavis ready"
		;;
	*)
		echo "amavis not responding"
		exit 1
		;;
esac
