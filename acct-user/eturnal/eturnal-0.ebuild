# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( turnserver )
ACCT_USER_HOME="/opt/eturnal/home"

acct-user_add_deps
