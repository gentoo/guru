# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Render Markdown with the C Library Sundown'
KEYWORDS="~amd64"
LICENSE='GPL-2'

DEPEND="
	>=dev-lang/R-2.11.1
	>=dev-R/mime-0.3
	dev-R/xfun
"
RDEPEND="${DEPEND}"
