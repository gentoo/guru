# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user for net-dns/blocky"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( "blocky" )

acct-user_add_deps
