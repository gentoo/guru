# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for fileshelter"
ACCT_USER_ID=-1
ACCT_USER_HOME=/var/lib/fileshelter
ACCT_USER_GROUPS=( fileshelter )

acct-user_add_deps
