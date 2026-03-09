#!/bin/sh
### BEGIN INIT INFO
# Short-Description: Start strongSwan VPN service
# Description:       Start strongSwan and charon with swanctl configuration and delay.
### END INIT INFO

DAEMON=/usr/libexec/ipsec/charon
SWANCTL=/usr/sbin/swanctl
NAME=strongswan
PIDFILE=/var/run/$NAME.pid
DELAY=10 # Delay in seconds

#optional
# . /lib/lsb/init-functions

do_start() {
    log_daemon_msg "Starting $NAME service"
    start-stop-daemon --start --quiet --background --pidfile $PIDFILE --exec $DAEMON || return 2
    
    log_daemon_msg "Applying delay of $DELAY seconds"
    sleep $DELAY
    
    log_daemon_msg "Loading swanctl configurations"
    $SWANCTL --load-all || return 2
    
    log_daemon_msg "Starting VPN connections"
    $SWANCTL --initiate || return 2
    
    log_end_msg 0
}

do_stop() {
    log_daemon_msg "Stopping $NAME service"
    start-stop-daemon --stop --quiet --pidfile $PIDFILE || return 2
    log_end_msg 0
}

case "$1" in
    start)
        do_start
        ;;
    stop)
        do_stop
        ;;
    restart|force-reload)
        do_stop
        do_start
        ;;
    status)
        status_of_proc -p $PIDFILE $DAEMON && exit 0 || exit $?
        ;;
    *)
        echo "Usage: /etc/init.d/$NAME {start|stop|restart|force-reload|status}"
        exit 1
        ;;
esac

exit 0
