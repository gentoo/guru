#!/sbin/openrc-run
# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

depend() {
	after netmount localmount
	need dbus
}

start() {
	ebegin "Starting oddjobd"
	start-stop-daemon -p /run/lock/oddjobd.pid \
	--exec /usr/sbin/oddjobd --start -- -p /run/lock/oddjobd.pid
	eend $?
}

stop() {
	ebegin "Stopping oddjobd"
	start-stop-daemon -p /run/lock/oddjobd.pid --stop
	eend $?
}
