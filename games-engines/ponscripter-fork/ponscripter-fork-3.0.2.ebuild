# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fork of the Ponscripter visual novel engine to take advantage of SDL2"
HOMEPAGE="https://github.com/07th-mod/ponscripter-fork"
SRC_URI="https://github.com/07th-mod/ponscripter-fork/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+mpeg +ogg"

RDEPEND="
	media-libs/libsdl2
	media-libs/sdl2-image[jpeg,png]
	media-libs/sdl2-mixer
	app-arch/bzip2:=
	media-libs/freetype
	virtual/jpeg
	media-libs/libogg
	media-libs/libpng
	media-libs/libvorbis
	media-libs/smpeg2
	sys-libs/zlib
"
DEPEND="${RDEPEND}"

BDEPEND="
	app-text/xmlto
	dev-lang/perl
"

src_prepare() {
	default

	rm -r src/extlib || die "Failed to remove bundled libraries"
	rm -r src/win_dll || die "Failed to remove Windows binaries"

	# Broken test for SDL2_Mixer
	sed -i '/^if \$EXTERNAL_SDL_MIXER$/,/^fi$/d' configure || die
}

src_configure() {
	./configure \
		--no-werror \
		--unsupported-compiler \
		--prefix="${EPREFIX}/usr" \
		--disable-internal-libs \
		--disable-steam
}

src_install() {
	einstalldocs
	emake PREFIX="${ED}/usr" install
	mv "${ED}/usr/man" "${ED}/usr/share" || die
}
