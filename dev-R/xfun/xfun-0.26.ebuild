# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Supporting Functions for Package maintained by Yihui Xie'
KEYWORDS="~amd64"
LICENSE='MIT'

SUGGESTED_PACKAGES="
	dev-R/testit
	dev-R/parallel
	dev-R/codetools
	dev-R/rstudioapi
	>=dev-R/tinytex-0.30
	dev-R/mime
	dev-R/markdown
	dev-R/knitr
	dev-R/htmltools
	dev-R/remotes
	dev-R/pak
	dev-R/rhub
	dev-R/renv
	dev-R/curl
	dev-R/jsonlite
	dev-R/rmarkdown
"
