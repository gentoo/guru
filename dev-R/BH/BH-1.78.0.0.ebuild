# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

MY_P="${PN}_$(ver_rs 3 -)"

DESCRIPTION='Boost C++ Header Files'
HOMEPAGE="
	https://github.com/eddelbuettel/bh
	https://cran.r-project.org/package=BH
"
SRC_URI="mirror://cran/src/contrib/${MY_P}.tar.gz"

LICENSE='Boost-1.0'
KEYWORDS="~amd64"
DEPEND=">=dev-libs/boost-$(ver_cut 1-3)"
RDEPEND="${DEPEND}"

src_prepare() {
	# Do not bundle boost
	rm -rf inst/include/boost || die
	default
}
