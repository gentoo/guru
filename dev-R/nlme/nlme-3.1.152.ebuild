# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Linear and Nonlinear Mixed Effects Models'
KEYWORDS="~amd64"
SRC_URI="http://cran.r-project.org/src/contrib/nlme_3.1-152.tar.gz"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.4.0
	virtual/lattice
	dev-lang/R[minimal]
"
RDEPEND="${DEPEND}"
