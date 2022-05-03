# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Cross-Platform File System Operations Based on libuv'
HOMEPAGE="
	https://cran.r-project.org/package=fs
	https://fs.r-lib.org/
	https://github.com/r-lib/fs
"

KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.1
	dev-libs/libuv
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-system-libuv.patch" )

src_prepare() {
	rm -r src/libuv-* || die
	R-packages_src_prepare
}

R_SUGGESTS="
	dev-R/covr
	dev-R/crayon
	dev-R/knitr
	>=dev-R/pillar-1.0.0
	dev-R/rmarkdown
	dev-R/spelling
	dev-R/testthat
	>=dev-R/tibble-1.1.0
	>=dev-R/vctrs-0.3.0
	dev-R/withr
"
