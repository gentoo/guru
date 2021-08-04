# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~s390 ~x86"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( gemini )

acct-user_add_deps
