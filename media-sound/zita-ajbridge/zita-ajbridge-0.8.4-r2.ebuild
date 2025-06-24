# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="zita-a2j and zita-j2a - bridges between ALSA and JACK"
HOMEPAGE="https://kokkinizita.linuxaudio.org/linuxaudio/zita-ajbridge-doc/quickguide.html"
SRC_URI="https://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/alsa-lib
	>=media-libs/zita-alsa-pcmi-0.3.0
	>=media-libs/zita-resampler-1.6.0
	virtual/jack
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.8.4-makefile.patch
)

src_compile() {
	tc-export CXX
	emake -C source
}

src_install() {
	local myemakeargs=(
		DESTDIR="${D}"
		PREFIX="${EPREFIX}/usr"
	)
	emake -C source "${myemakeargs[@]}" install

	einstalldocs
}
