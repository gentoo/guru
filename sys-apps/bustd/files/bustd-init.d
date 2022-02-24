#!/sbin/openrc-run
# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

pidfile="/run/bustd.pid"
command="/usr/bin/bustd"
command_args="${BUSTD_OPTS}"
command_background=1
