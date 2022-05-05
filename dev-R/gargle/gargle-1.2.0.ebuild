# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Utilities for Working with Google APIs'
HOMEPAGE="
	https://cran.r-project.org/package=gargle
	https://gargle.r-lib.org/
	https://github.com/r-lib/gargle
"

KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-R/cli-3.0.0
	>=dev-R/httr-1.4.0
	dev-R/withr
	>=dev-R/glue-1.3.0
	>=dev-lang/R-3.3
	>=dev-R/fs-1.3.1
	dev-R/jsonlite
	dev-R/rappdirs
	>=dev-R/rlang-0.4.9
	dev-R/rstudioapi
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/aws_ec2metadata
	dev-R/aws_signature
	dev-R/covr
	dev-R/httpuv
	dev-R/knitr
	dev-R/mockr
	dev-R/rmarkdown
	dev-R/spelling
	>=dev-R/testthat-3.0.0
"
