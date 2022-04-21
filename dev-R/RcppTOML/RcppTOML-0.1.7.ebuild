# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Rcpp Bindings to C++ parser for TOML files'
HOMEPAGE="
	https://cran.r-project.org/package=RcppTOML
	https://github.com/eddelbuettel/rcpptoml
"
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	dev-cpp/cpptoml
	>=dev-lang/R-3.3.0
	>=dev-R/Rcpp-0.11.5
"
RDEPEND="${DEPEND}"

src_prepare() {
	rm -r inst/tinytest || die
	# replace bundled cpptoml
	rm inst/include/cpptoml.h || die
	ln -s /usr/include/cpptoml.h inst/include/cpptoml.h || die
	R-packages_src_prepare
}

src_install() {
	R-packages_src_install
	rm "${ED}/usr/lib64/R/site-library/RcppTOML/include/cpptoml.h" || die
	dosym ../../../../../../usr/include/cpptoml.h "${EPREFIX}/usr/lib64/R/site-library/RcppTOML/include/cpptoml.h"
}

SUGGESTED_PACKAGES="dev-R/tinytest"
