# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for www-apps/jackett-bin"
KEYWORDS="~amd64 ~arm64 ~x86"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( purritobin )

acct-user_add_deps
