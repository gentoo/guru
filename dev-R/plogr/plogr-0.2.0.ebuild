# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='The plog C++ Logging Library'
HOMEPAGE="
	https://github.com/krlmlr/plogr
	https://cran.r-project.org/package=plogr
"
LICENSE='MIT'
KEYWORDS="~amd64"
RDEPEND="
	dev-cpp/plog
"
DEPEND="${RDEPEND}"

src_prepare() {
	#do not bundle plog
	rm -rf inst/include || die
	default
}
