# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Tools for Spell Checking in R'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	dev-R/commonmark
	>=dev-R/hunspell-3.0
	dev-R/xml2
	dev-R/knitr
"
RDEPEND="${DEPEND}"
