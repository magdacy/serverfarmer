#!/bin/bash
# Konfiguracja Midnight Commandera

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



if [ -f $base/mc.ini ]; then
	echo "setting up midnight commander profiles"

	if [ -f $base/mc.skin ]; then
		cp -f $base/mc.skin /usr/share/mc/skins/wheezy.ini
	fi

	if [ "`grep -Fx $OSVER $common/mc.newpaths.conf`" != "" ]; then
		SUB=".config/mc/ini"
	else
		SUB=".mc/ini"
	fi

	cp -f $base/mc.ini /root/$SUB
	chown root:root /root/$SUB

	ADMIN=`primary_admin_account`

	if [ "`getent passwd $ADMIN`" != "" ]; then
		DIR=`getent passwd $ADMIN |cut -d: -f 6`
		cp -f $base/mc.ini $DIR/$SUB
		chown $ADMIN:$ADMIN $DIR/$SUB
	fi
fi


loc="/usr/share/locale/pl/LC_MESSAGES"

if [ -f $loc/mc.mo ]; then
	echo "disabling midnight commander polish translation"
	mv $loc/mc.mo $loc/midc.mo
fi

