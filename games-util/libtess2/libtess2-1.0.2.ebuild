# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Game and tools oriented refactored version of GLU tesselator"

HOMEPAGE="https://github.com/memononen/libtess2"
SRC_URI="https://github.com/memononen/libtess2/archive/refs/tags/v${PV}.tar.gz -> $P.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=media-libs/glew-2.2.0
	>=media-libs/glfw-3.0.0
	>=media-libs/glu-9.0.2
"

src_unpack() {
	default
	cp "${FILESDIR}/meson.build" "${S}/" || die
}
