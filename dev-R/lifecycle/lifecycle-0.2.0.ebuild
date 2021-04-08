# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Manage the Life Cycle of your Package Functions'
HOMEPAGE="
	https://lifecycle.r-lib.org
	https://github.com/r-lib/lifecycle
	https://cran.r-project.org/package=lifecycle
"
SRC_URI="mirror://cran/src/contrib/lifecycle_0.2.0.tar.gz"
LICENSE='GPL-3'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
DEPEND="
	>=dev-lang/R-3.2
	dev-R/glue
	>=dev-R/rlang-0.4.0
"
RDEPEND="${DEPEND-}"
