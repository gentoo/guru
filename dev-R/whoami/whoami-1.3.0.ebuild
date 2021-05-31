# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Username, Full Name, Email Address, GitHub username of the current user'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	dev-R/httr
	dev-R/jsonlite
"
RDEPEND="${DEPEND}"
