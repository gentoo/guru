# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( mobilizon )
ACCT_USER_HOME="/opt/mobilizon"

acct-user_add_deps
