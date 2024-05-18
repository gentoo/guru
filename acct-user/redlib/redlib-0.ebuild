# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for Redlib"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( redlib )

acct-user_add_deps
