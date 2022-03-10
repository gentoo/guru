# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='High Performance CommonMark and github markdown rendering in R'
KEYWORDS="~amd64"
LICENSE='BSD-2'

SUGGESTED_PACKAGES="
	dev-R/curl
	dev-R/testthat
	dev-R/xml2
"
