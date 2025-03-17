#!/bin/sh

_FUNCTIONS=/etc/rc.d/functions
[ -f ${_FUNCTIONS} ] && . ${_FUNCTIONS}

NAME="onlinescreensaver"
DESC="Online Screensaver"
PIDFILE=/var/run/$NAME.pid
INSTALLDIR=/mnt/us/extensions/onlinescreensaver

start() {
        msg "Starting $DESC..." I
        start-stop-daemon -S -b -m -p $PIDFILE -v -x $INSTALLDIR/bin/scheduler.sh
}

stop() {
        msg "Stopping $DESC..." I
        start-stop-daemon -K -p $PIDFILE -v
}

case "$1" in
        start)
                start
                ;;
        stop)
                stop
                ;;

        restart | force-reload)
                stop
                start
                ;;
        *)
                msg "usage: /etc/init.d/$NAME {start|stop|restart}" W >&2
                exit 1
                ;;

esac

exit 0
