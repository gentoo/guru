# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='High Performance Colour Space Manipulation'
HOMEPAGE="
	https://cran.r-project.org/package=farver
	https://farver.data-imaginist.com/
	https://github.com/thomasp85/farver
"

KEYWORDS="~amd64"
LICENSE='MIT'

SUGGESTED_PACKAGES="
	dev-R/covr
	>=dev-R/testthat-3.0.0
"
