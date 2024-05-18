# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Game and tools oriented refactored version of GLU tesselator"

HOMEPAGE="https://gitlab.eurecom.fr/gasc/libtess2"
SRC_URI="https://gitlab.eurecom.fr/gasc/libtess2/-/archive/v${PV}/libtess2-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=media-libs/glew-2.2.0
	>=media-libs/glfw-3.0.0
	>=media-libs/glu-9.0.2"
BDEPEND="
	${DEPEND}
	>=dev-util/premake-5.0.0_alpha16"

src_compile() {
	emake clean build
}

src_install() {
	echo ${D}
	emake DESTDIR="${D}/usr" install
}
