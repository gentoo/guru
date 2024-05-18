# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for net-misc/wsdd"
# might become 513 (month-day of initial user/group ebuild creation) in the future
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( ${PN} )

acct-user_add_deps
