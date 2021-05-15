# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KEYWORDS="~amd64 ~arm ~x86"

inherit acct-group

DESCRIPTION="Group for net-misc/wsdd"
# might become 513 (month-day of initial user/group ebuild creation) in the future
ACCT_GROUP_ID=-1
