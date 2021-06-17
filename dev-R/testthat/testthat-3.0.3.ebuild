# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Unit Testing for R'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.1
	dev-R/brio
	>=dev-R/callr-3.5.1
	>=dev-R/cli-2.2.0
	>=dev-R/crayon-1.3.4
	dev-R/desc
	dev-R/digest
	>=dev-R/ellipsis-0.2.0
	dev-R/evaluate
	dev-R/jsonlite
	dev-R/lifecycle
	dev-R/magrittr
	dev-R/pkgload
	dev-R/praise
	dev-R/processx
	>=dev-R/ps-1.3.4
	>=dev-R/R6-2.2.0
	>=dev-R/rlang-0.4.9
	>=dev-R/waldo-0.2.4
	>=dev-R/withr-2.3.0
"
RDEPEND="${DEPEND}"
