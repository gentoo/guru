# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for fcitx5-lotus uinput proxy server"

ACCT_USER_ID="-1"
ACCT_USER_GROUPS=( input )

acct-user_add_deps
