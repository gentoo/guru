# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Execute and Control System Processes'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.4.0
	>=dev-R/ps-1.2.0
	dev-R/R6
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	>=dev-R/callr-3.7.0
	>=dev-R/cli-1.1.0
	dev-R/codetools
	dev-R/covr
	dev-R/curl
	dev-R/debugme
	>=dev-R/testthat-3.0.0
	dev-R/withr
"
