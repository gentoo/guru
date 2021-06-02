# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Tools for Working with URLs and HTTP'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.2
	>=dev-R/curl-3.0.0
	>=dev-R/openssl-0.8
	dev-R/mime
	dev-R/jsonlite
	dev-R/R6
"
RDEPEND="${DEPEND}"
