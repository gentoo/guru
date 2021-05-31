# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Find Differences Between R Objects'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-R/rlang-0.4.10
	dev-R/tibble
	dev-R/fansi
	dev-R/diffobj
	dev-R/cli
	dev-R/glue
	dev-R/rematch2
"
RDEPEND="${DEPEND}"
