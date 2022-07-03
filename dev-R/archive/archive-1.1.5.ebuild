# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Multi-Format Archive and Compression Support'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/cli
	dev-R/glue
	dev-R/rlang
	dev-R/tibble
	dev-R/cpp11
	test? (
		dev-R/testthat
	)
	app-arch/libarchive[bzip2,lz4,lzma,lzo,zstd]
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/testthat
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
