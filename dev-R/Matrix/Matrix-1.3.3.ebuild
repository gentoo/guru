# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Sparse and Dense Matrix Classes and Methods'
KEYWORDS="~amd64"
SRC_URI="http://cran.r-project.org/src/contrib/Matrix_1.3-3.tar.gz"
LICENSE='GPL-2+'

DEPEND="
	virtual/lattice
	>=dev-lang/R-3.5.0
	dev-lang/R[minimal]
"
RDEPEND="${DEPEND}"
