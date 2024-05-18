# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C++ tweening (inbetweening) library"
HOMEPAGE="https://mobius3.github.io/tweeny/"
SRC_URI="https://github.com/mobius3/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

src_prepare() {
	cmake_src_prepare

	if use doc; then
		sed -i "s@DESTINATION share/doc/Tweeny@DESTINATION share/doc/${PF}@" \
			doc/CMakeLists.txt || die "Could not change documentation path."
	fi
}

src_configure() {
	local -a mycmakeargs=(
		-DTWEENY_BUILD_DOCUMENTATION=$(usex doc)
	)

	cmake_src_configure
}
