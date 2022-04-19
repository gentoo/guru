# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='A Simpler Way to Find Your Files'
HOMEPAGE="
	https://cran.r-project.org/package=here
	https://here.r-lib.org/
	https://github.com/r-lib/here
"
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND=">=dev-R/rprojroot-2.0.2"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/conflicted
	dev-R/covr
	dev-R/fs
	dev-R/knitr
	dev-R/palmerpenguins
	dev-R/plyr
	dev-R/readr
	dev-R/rlang
	dev-R/rmarkdown
	dev-R/testthat
	dev-R/uuid
	dev-R/withr
"
