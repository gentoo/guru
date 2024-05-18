# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="VVdeC, the Fraunhofer Versatile Video Decoder"
HOMEPAGE="https://www.hhi.fraunhofer.de/en/departments/vca/technologies-and-solutions/h266-vvc.html"
SRC_URI="https://github.com/fraunhoferhhi/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Clear-BSD"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	local mycmakeargs=(
		-DVVDEC_INSTALL_VVDECAPP="ON"
	)
	cmake_src_configure
}

src_install() {
	#dobin "${BUILD_DIR}/vvdec"
	#dobin "${BUILD_DIR}/vvdecapp"
	#dolib "${BUILD_DIR}"
	#insinto /usr/share/${PN}
	#doins -r res/*

	#make_desktop_entry /usr/bin/${PN}
	cmake_src_install
}
