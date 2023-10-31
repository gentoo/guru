# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for www-apps/rimgo"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( rimgo )
ACCT_USER_HOME="/var/empty"
acct-user_add_deps
SLOT="0"
