#!/bin/sh

# change to directory of this script
cd "$(dirname "$0")"
INSTALLDIR=/mnt/us/extensions/onlinescreensaver

# load configuration
if [ -e "config.sh" ]; then
	source $INSTALLDIR/bin/config.sh
fi

# load utils
if [ -e "utils.sh" ]; then
	source $INSTALLDIR/bin/utils.sh
else
	echo "Could not find utils.sh"
	exit
fi

# forever and ever, try to update the screensaver
logger "Disabling online screensaver auto-update"

if [ -e /etc/upstart ]; then
	logger "Setting up Upstart service"
	stop onlinescreensaver || true  

	mntroot rw
	rm /etc/upstart/onlinescreensaver.conf
	mntroot ro
else [ -e /etc/init.d ]; then
	/etc/init.d/onlinescreensaver stop

	mntroot rw
	rm /etc/init.d/onlinescreensaver
	rm /etc/rc5.d/onlinescreensaver
	mntroot ro
fi
   

