# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="An user for www-apps/librarian"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( librarian )
ACCT_USER_HOME="/var/cache/${PN}"
acct-user_add_deps
SLOT="0"
