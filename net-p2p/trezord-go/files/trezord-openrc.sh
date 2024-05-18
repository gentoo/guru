#!/sbin/openrc-run
# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

command="/usr/bin/trezord"
pidfile="/run/${RC_SVCNAME}.pid"
command_args="-l /var/log/trezord/trezord.log"
command_user="trezord"
command_background=true
