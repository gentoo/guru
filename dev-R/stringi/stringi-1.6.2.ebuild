# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Character String Processing Facilities'
KEYWORDS="~amd64"
LICENSE="GPL-2+ BSD public-domain MIT"

DEPEND="
	>=dev-lang/R-3.1
	>=dev-libs/icu-55
"
RDEPEND="${DEPEND}"
