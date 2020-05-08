# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Match Regular Expressions with a Nicer API'
HOMEPAGE="
	https://github.com/MangoTheCat/rematch
	https://cran.r-project.org/package=rematch
"
SRC_URI="http://cran.r-project.org/src/contrib/rematch_1.0.1.tar.gz"
LICENSE='MIT'

IUSE="${IUSE-}"
KEYWORDS="~amd64"
