# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit acct-user

DESCRIPTION="User for www-servers/copyparty"

ACCT_USER_ID=-1
ACCT_USER_HOME=/var/lib/copyparty
ACCT_USER_GROUPS=( copyparty )

acct-user_add_deps
