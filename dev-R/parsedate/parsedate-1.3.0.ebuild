# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Recognize and Parse Dates in Various Formats'
HOMEPAGE="
	https://github.com/gaborcsardi/parsedate
	https://cran.r-project.org/package=parsedate
"

KEYWORDS="~amd64"
LICENSE='GPL-2'

SUGGESTED_PACKAGES="
	sci-CRAN/covr
	sci-CRAN/testthat
	sci-CRAN/withr
"
