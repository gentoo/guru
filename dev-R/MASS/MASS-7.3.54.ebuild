# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION="Support Functions and Datasets for variables and Ripley's MASS"
KEYWORDS="~amd64"
SRC_URI="mirror://cran/src/contrib/MASS_7.3-54.tar.gz"
LICENSE='|| ( GPL-2 GPL-3 )'

DEPEND="
	>=dev-lang/R-3.3.0
	dev-lang/R[minimal]
"
RDEPEND="${DEPEND}"
