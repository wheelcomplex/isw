#!/bin/sh
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=isw
# https://github.com/YoyPa/isw

if [ -s /etc/isw.conf -o -x /usr/bin/isw ]
then
	echo "isw already installed."
	echo "remove /etc/isw.conf /usr/bin/isw for reinstall."
	exit 1
fi
if [ `id -u` -ne 0 ]
then
	sudo $0 $@
	exit $?
fi
if [ ! -s etc/isw.conf -o ! -x isw ]
then
	echo "This script must run in the git directory."
	exit 1
fi

pkgdir=""

set -e

opt=""
if [ "$1" = "-v" ]
then
	opt="v"
fi

install -Dm${opt} 644 etc/isw.conf "${pkgdir}/etc/isw.conf"
install -Dm${opt} 644 etc/modprobe.d/isw-ec_sys.conf "${pkgdir}/etc/modprobe.d/isw-ec_sys.conf"
install -Dm${opt} 644 etc/modules-load.d/isw-ec_sys.conf "${pkgdir}/etc/modules-load.d/isw-ec_sys.conf"
install -Dm${opt} 644 usr/lib/systemd/system/isw@.service "${pkgdir}/usr/lib/systemd/system/isw@.service"
install -Dm${opt} 755 isw "${pkgdir}/usr/bin/isw"
echo "USAGE:"
/usr/bin/isw -h
