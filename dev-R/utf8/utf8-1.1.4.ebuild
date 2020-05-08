# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

HOMEPAGE="
	https://github.com/patperry/r-utf8
	https://cran.r-project.org/package=utf8
"
DESCRIPTION='Unicode Text Processing'
SRC_URI="http://cran.r-project.org/src/contrib/utf8_1.1.4.tar.gz"
LICENSE='Apache-2.0'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
