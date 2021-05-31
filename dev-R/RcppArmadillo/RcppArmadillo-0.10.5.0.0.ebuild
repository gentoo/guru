# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Rcpp Integration for the Armadillo templated linear algebra library'
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.3.0
	>=dev-R/Rcpp-0.11.0
	sci-libs/armadillo[lapack]
"
RDEPEND="
	${DEPEND}
	dev-R/Rcpp
"

#TODO: correctly link to lapack

src_prepare() {
	default
	rm -r inst/include/armadillo_bits || die
	rm inst/include/armadillo || die
	dosym /usr/include/armadillo_bits inst/include/armadillo_bits
	dosym /usr/include/armadillo inst/include/armadillo
}

src_install() {
	R-packages_src_install
	dosym /usr/include/armadillo_bits "/usr/$(get_libdir)/R/site-library/${PN}/include/armadillo_bits"
	dosym /usr/include/armadillo "/usr/$(get_libdir)/R/site-library/${PN}/include/armadillo"
}
