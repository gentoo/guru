# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Colored Terminal Output'
HOMEPAGE="
	https://github.com/r-lib/crayon
	https://cran.r-project.org/package=crayon
"
SRC_URI="http://cran.r-project.org/src/contrib/crayon_1.3.4.tar.gz"
LICENSE='MIT'

IUSE="${IUSE-}"
