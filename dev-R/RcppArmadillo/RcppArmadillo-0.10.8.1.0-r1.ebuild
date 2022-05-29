# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages eapi8-dosym

MY_PV="$(ver_cut 2-3 ${PV})"

DESCRIPTION='Rcpp Integration for the Armadillo templated linear algebra library'
SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"

SLOT="0/${PV}"
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.3.0
	>=dev-R/Rcpp-0.11.0
	=sci-libs/armadillo-${MY_PV}*:=[lapack]
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/tinytest
	virtual/Matrix
	dev-R/pkgKitten
	dev-R/reticulate
	dev-R/slam
"

#TODO: correctly link to lapack

src_prepare() {
	R-packages_src_prepare

	#remove bundled
	rm -r inst/include/armadillo_bits || die
	rm inst/include/armadillo || die

	#link to sci-libs/armadillo
	ln -s "${ESYSROOT}"/usr/include/armadillo_bits inst/include/armadillo_bits || die
	ln -s "${ESYSROOT}"/usr/include/armadillo inst/include/armadillo || die
}

src_install() {
	R-packages_src_install

	R_includedir="/usr/$(get_libdir)/R/site-library/${PN}/include"
	dosym8 -r /usr/include/armadillo "${R_includedir}/armadillo"

	dodir /usr/include/armadillo_bits
	for file in "${ED}/${R_includedir}"/armadillo_bits/*; do
		filename=$(basename "${file}")
		dosym8 -r /usr/include/armadillo_bits/${filename} "${R_includedir}/armadillo_bits/${filename}"
	done
}
