# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for Canna language server"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( canna )
ACCT_USER_HOME="/var/lib/${PN}"

acct-user_add_deps
