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

logger "Checking online screensaver auto-update"
if [ -e /etc/upstart ]; then
	logger "Setting up Upstart service"

	mntroot rw
	cp $INSTALLDIR/initscripts/upstart.conf /etc/upstart/onlinescreensavers.conf
	mntroot ro

	start onlinescreensaver
else [ -e /etc/init.d ]; then
	logger "Setting up Init.d service"

	mntroot rw
	cp $INSTALLDIR/bin/initscripts/sysvinit.sh /etc/init.d/onlinescreensaver
	ln -s /etc/init.d/onlinescreensaver  /etc/rc5.d/onlinescreensaver
	mntroot ro

	/etc/init.d/onlinescreensaver start
else
	logger "Service system not found, device too old?"
fi
