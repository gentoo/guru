# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='A General-Purpose Package for Dynamic report generation in R'
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-R/yaml-2.1.19
	>=dev-R/xfun-0.27
	>=dev-R/evaluate-0.10
	dev-R/highr
	>=dev-lang/R-3.2.3
	>=dev-R/stringr-0.6
"
RDEPEND="
	${DEPEND}
	app-text/pandoc
"

SUGGESTED_PACKAGES="
	dev-R/markdown
	dev-R/formatR
	dev-R/testit
	dev-R/digest
	>=dev-R/rgl-0.95.1201
	dev-R/codetools
	dev-R/rmarkdown
	>=dev-R/htmlwidgets-0.7
	dev-R/webshot
	>=dev-R/tikzDevice-0.10
	dev-R/tinytex
	>=dev-R/reticulate-1.4
	>=dev-R/JuliaCall-0.11.1
	dev-R/magick
	dev-R/png
	dev-R/jpeg
	dev-R/gifski
	>=dev-R/xml2-1.2.0
	dev-R/httr
	>=dev-R/DBI-0.4.1
	dev-R/showtext
	dev-R/tibble
	dev-R/sass
	dev-R/bslib
	dev-R/ragg
	>=dev-R/styler-1.2.0
	>=dev-R/targets-0.6.0
"
