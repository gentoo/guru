# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Trellis Graphics for R'
KEYWORDS="~amd64"
SRC_URI="http://cran.r-project.org/src/contrib/lattice_0.20-44.tar.gz"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.0.0
	dev-lang/R[minimal]
"
RDEPEND="${DEPEND}"
