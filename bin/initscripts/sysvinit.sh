#!/bin/sh
 
 _FUNCTIONS=/etc/rc.d/functions
 [ -f ${_FUNCTIONS} ] && . ${_FUNCTIONS}
 
 start()
 {
         
 }
 
 stop()
 {

 }
 
 case "$1" in
         start)
                 start
                 ;;
         stop)
                 stop
                 ;;
 
         restart|force-reload)
                 :
                 ;;
         *)
         msg "usage: /etc/init.d/$NAME {start|stop}" W >&2
                 exit 1
                 ;;
 
 esac
 
 exit 0