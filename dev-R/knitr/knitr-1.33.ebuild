# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='A General-Purpose Package for Dynamic report generation in R'
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-R/yaml-2.1.19
	>=dev-R/xfun-0.21
	>=dev-R/evaluate-0.10
	dev-R/highr
	>=dev-lang/R-3.2.3
	dev-R/markdown
	>=dev-R/stringr-0.6
"
RDEPEND="
	${DEPEND}
	app-text/pandoc
"
