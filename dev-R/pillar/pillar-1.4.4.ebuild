# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Coloured Formatting for Columns'
HOMEPAGE="
	https://github.com/r-lib/pillar
	https://cran.r-project.org/package=pillar
"
SRC_URI="http://cran.r-project.org/src/contrib/pillar_1.4.4.tar.gz"
LICENSE='GPL-3'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
DEPEND="
	dev-R/cli
	>=dev-R/crayon-1.3.4
	dev-R/fansi
	>=dev-R/rlang-0.3.0
	>=dev-R/vctrs-0.2.0
	>=dev-R/utf8-1.1.0
"
RDEPEND="${DEPEND-}"
