# Copyright 1999-2026 Gentoo Authors
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
	cmake_src_install
}
