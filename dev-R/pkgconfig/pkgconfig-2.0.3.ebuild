# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Private Configuration for R Packages'
HOMEPAGE="
	https://github.com/r-lib/pkgconfig
	https://cran.r-project.org/package=pkgconfig
"
SRC_URI="http://cran.r-project.org/src/contrib/pkgconfig_2.0.3.tar.gz"
LICENSE='MIT'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
