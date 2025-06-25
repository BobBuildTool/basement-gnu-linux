#!/bin/sh
#
# Synchronize to hw clock
#

start() {
  hwclock -us
}

stop() {
  hwclock -uw
}

restart() {
	stop
	sleep 1
	start
}

case "$1" in
	start|stop|restart)
		"$1";;
	reload)
		# Restart, since there is no true "reload" feature.
		restart;;
	*)
		echo "Usage: $0 {start|stop|restart|reload}"
		exit 1
esac
