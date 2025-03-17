#!/bin/sh

# change to directory of this script
cd "$(dirname "$0")"
INSTALLDIR=/mnt/us/extensions/onlinescreensaver
DAMONNAME=onlinescreensaver

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
logger "Disabling $DAMONNAME auto-update"

if [ -e /etc/upstart ]; then
	logger "Setting up Upstart service"
	stop $DAMONNAME || true

	mntroot rw
	rm /etc/upstart/$DAMONNAME.conf
	mntroot ro
elif [ -e /etc/init.d ]; then
	/etc/init.d/$DAMONNAME stop

	mntroot rw
	rm /etc/init.d/$DAMONNAME
	rm /etc/rc5.d/$DAMONNAME
	mntroot ro
fi
