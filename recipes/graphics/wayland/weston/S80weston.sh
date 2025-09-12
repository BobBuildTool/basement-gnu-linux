#!/bin/sh

# This file comes from buildroot and is licensed under GPLv2.

DAEMON="weston"
DAEMON_ARGS="--continue-without-input --log=/var/log/$DAEMON.log"

[ -r "/etc/default/$DAEMON" ] && . "/etc/default/$DAEMON"

start() {
  printf 'Starting %s: ' "$DAEMON"
  export XDG_RUNTIME_DIR=/run/user/`id -u ${WESTON_USER}`
  if ! test -d "$XDG_RUNTIME_DIR"; then
    mkdir -p $XDG_RUNTIME_DIR
    chmod 0700 $XDG_RUNTIME_DIR
  fi
  if ! test -d "/tmp/.X11-unix"; then
    mkdir -p /tmp/.X11-unix
  fi
  export WESTON_DISABLE_GBM_MODIFIERS=1
  unset DISPLAY
  unset WAYLAND_DISPLAY
  # shellcheck source=/dev/null
  start-stop-daemon -b -m -S -q -p "$PIDFILE" -x "/usr/bin/$DAEMON" -- $DAEMON_ARGS
  status=$?
  if [ "$status" -eq 0 ]; then
    echo "OK"
  else
    echo "FAIL"
  fi
  return "$status"
}

stop() {
  printf 'Stopping %s: ' "$DAEMON"
  echo "OK"
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
