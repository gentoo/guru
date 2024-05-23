# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for OpenBGPD"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( _bgpd )
ACCT_USER_HOME=/var/empty

acct-user_add_deps
