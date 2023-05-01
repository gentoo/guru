# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit python-single-r1 R-packages

DESCRIPTION='Interface to Python'
HOMEPAGE="
	https://rstudio.github.io/reticulate/
	https://github.com/rstudio/reticulate
	https://cran.r-project.org/package=reticulate
"

KEYWORDS="~amd64"
LICENSE='Apache-2.0'

DEPEND="
	dev-R/jsonlite
	dev-R/rappdirs
	>=dev-R/Rcpp-0.12.7
	>=dev-lang/R-3.0
	dev-R/RcppTOML
	virtual/Matrix
	dev-R/here
	dev-R/png
	dev-R/withr
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_install() {
	R-packages_src_install

	python_optimize "${ED}/usr/$(get_libdir)/R/site-library/reticulate/python/rpytools"

	# enforce python implementation
	echo "RETICULATE_PYTHON=\"${PYTHON}\"" > "${T}/99reticulate" || die
	doenvd "${T}/99reticulate"
}

SUGGESTED_PACKAGES="
	dev-R/callr
	dev-R/knitr
	dev-R/rlang
	dev-R/rmarkdown
	dev-R/testthat
"
