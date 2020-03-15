# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for TREZOR Bridge"
KEYWORDS="~amd64 ~x86"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( plugdev )

acct-user_add_deps
