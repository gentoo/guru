# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for net-im/biboumi"
KEYWORDS="~amd64"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( biboumi )

acct-user_add_deps
