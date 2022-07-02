# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='HTTP and WebSocket Server Library'
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-R/Rcpp-1.0.7
	dev-R/R6
	dev-R/promises
	>=dev-R/later-0.8.0
	sys-libs/zlib
"

SUGGESTED_PACKAGES="
	dev-R/testthat
	dev-R/callr
	dev-R/curl
	dev-R/websocket
"
