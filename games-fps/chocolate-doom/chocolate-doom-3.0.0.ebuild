# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit python-any-r1 xdg

DESCRIPTION="A Doom source port that is minimalist and historically accurate"
HOMEPAGE="https://www.chocolate-doom.org"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/${P}/${P}.tar.gz"

LICENSE="BSD GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libsamplerate png python timidity +vorbis"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer[timidity?,vorbis?]
	media-libs/sdl2-net
	libsamplerate? ( media-libs/libsamplerate )
	png? ( media-libs/libpng:= )"
RDEPEND="${DEPEND}"
BDEPEND="python? ( ${PYTHON_DEPS} )"

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${P}/docs" \
		$(use_with libsamplerate) \
		$(use_with png libpng)
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
