#!/bin/sh

# change to directory of this script
cd "$(dirname "$0")"

# load configuration
if [ -e "config.sh" ]; then
	source /mnt/us/extensions/onlinescreensaver/bin/config.sh
fi

# load utils
if [ -e "utils.sh" ]; then
	source /mnt/us/extensions/onlinescreensaver/bin/utils.sh
else
	echo "Could not find utils.sh in `pwd`"
	exit
fi

logger "Checking online screensaver auto-update"
if [ -e /etc/upstart ]; then
	logger "Setting up Upstart service"

	# TODO: revert

	start onlinescreensaver
else [ -e /etc/init.d ]; then
	logger "Setting up Init.d service"

	mntroot rw
	cp /mnt/us/extensions/onlinescreensaver/bin/sysv-init.sh /etc/init.d/onlinescreensaver
	ln -s /etc/init.d/onlinescreensaver  /etc/rc5.d/onlinescreensaver
	mntroot ro

	/etc/init.d/onlinescreensaver start
else
	logger "Service system not found, device too old?"
fi
