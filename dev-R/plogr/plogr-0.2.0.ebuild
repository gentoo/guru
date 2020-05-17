# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='The plog C++ Logging Library'
SRC_URI="http://cran.r-project.org/src/contrib/plogr_0.2.0.tar.gz"
HOMEPAGE="
	https://github.com/krlmlr/plogr
	https://cran.r-project.org/package=plogr
"
LICENSE='MIT'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
RDEPEND="
	dev-cpp/plog
"
DEPEND="${RDEPEND}"

src_prepare() {
	#do not bundle plog
	rm -rf inst/include || die
	default
}
