# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='ANSI Control Sequence Aware String Functions'
HOMEPAGE="
	https://github.com/brodieG/fansi
	https://cran.r-project.org/package=fansi
"
SRC_URI="http://cran.r-project.org/src/contrib/fansi_0.4.1.tar.gz"
LICENSE='GPL-2+'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
DEPEND=">=dev-lang/R-3.1.0"
RDEPEND="${DEPEND}"
