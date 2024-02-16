# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

# TODO(NRK):
# - enable tests
# - useflag to not build md2html tool
# - useflag for static lib (?)

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mity/md4c.git"
else
	MY_VERSION="release-${PV}"
	SRC_URI="https://github.com/mity/${PN}/archive/refs/tags/${MY_VERSION}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${MY_VERSION}"
fi

DESCRIPTION="C Markdown parser. Fast, SAX-like interface, CommonMark Compliant."
HOMEPAGE="https://github.com/mity/md4c"

LICENSE="MIT"
SLOT="0"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	find "${ED}/usr/$(get_libdir)" -name '*.a' -exec rm {} \; || die
}
