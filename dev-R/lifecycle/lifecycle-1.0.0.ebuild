# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Manage the Life Cycle of your Package Functions'
HOMEPAGE="
	https://lifecycle.r-lib.org
	https://github.com/r-lib/lifecycle
	https://cran.r-project.org/package=lifecycle
"
LICENSE='GPL-3'
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.3
	dev-R/glue
	>=dev-R/rlang-0.4.10
"
RDEPEND="${DEPEND}"
