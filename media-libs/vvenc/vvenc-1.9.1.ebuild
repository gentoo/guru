# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The Fraunhofer Versatile Video Encoder (VVenC) is a fast and efficient H.266/VVC encoder implementation."
HOMEPAGE="https://www.hhi.fraunhofer.de/en/departments/vca/technologies-and-solutions/h266-vvc.html"
SRC_URI="https://github.com/fraunhoferhhi/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="BSD-3-Clause-Clear"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DVVENC_INSTALL_FULLFEATURE_APP="ON"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
