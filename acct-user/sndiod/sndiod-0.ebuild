# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="daemon user for sndio"
KEYWORDS="~amd64"
ACCT_USER_ID="-1"
ACCT_USER_GROUPS=( audio )
ACCT_USER_HOME=/var/lib/sndio

acct-user_add_deps
