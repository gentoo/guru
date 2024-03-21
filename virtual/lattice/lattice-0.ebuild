# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual of a R recommended package"
SRC_URI=""

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	|| (
		dev-lang/R[-minimal]
		dev-R/lattice
	)
"
