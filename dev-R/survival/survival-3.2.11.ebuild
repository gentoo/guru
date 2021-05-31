# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Survival Analysis'
SRC_URI="mirror://cran/src/contrib/survival_3.2-11.tar.gz"
KEYWORDS="~amd64"
LICENSE='LGPL-2+'

DEPEND="
	virtual/Matrix
	dev-lang/R[minimal]
	>=dev-lang/R-3.5.0
"
RDEPEND="${DEPEND}"
