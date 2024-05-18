# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="Build user for sys-apps/paludis"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( paludisbuild tty )
ACCT_USER_HOME="/var/tmp/paludis"

acct-user_add_deps
