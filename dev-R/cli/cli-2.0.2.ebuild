# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Helpers for Developing Command Line Interfaces'
HOMEPAGE="
	https://github.com/r-lib/cli
	https://cran.r-project.org/package=cli
"
SRC_URI="http://cran.r-project.org/src/contrib/cli_2.0.2.tar.gz"
LICENSE='MIT'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
DEPEND="
	dev-R/assertthat
	>=dev-R/crayon-1.3.4
	dev-R/fansi
	dev-R/glue
"
RDEPEND="${DEPEND-}"
