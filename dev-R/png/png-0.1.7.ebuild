# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

MYPV="$(ver_rs 2 -)"

DESCRIPTION='Read and write PNG images'
HOMEPAGE="
	https://cran.r-project.org/package=png
	http://www.rforge.net/png/
"
SRC_URI="mirror://cran/src/contrib/${PN}_${MYPV}.tar.gz"

KEYWORDS="~amd64"
LICENSE='|| ( GPL-2 GPL-3 )'

RDEPEND="
	${DEPEND}
	media-libs/libpng
"
