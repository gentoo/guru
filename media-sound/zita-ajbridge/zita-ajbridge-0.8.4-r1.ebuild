# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="zita-a2j and zita-j2a - bridges between ALSA and JACK"
HOMEPAGE="https://kokkinizita.linuxaudio.org/linuxaudio/zita-ajbridge-doc/quickguide.html"
SOURCE_URI="https://kokkinizita.linuxaudio.org/linuxaudio/downloads"
SRC_URI="${SOURCE_URI}/${PN}-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/alsa-lib
>=media-libs/zita-alsa-pcmi-0.3.0
>=media-libs/zita-resampler-1.6.0
virtual/jack"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/gzip"

S="${WORKDIR}/${P}/source"
ADIR="${WORKDIR}/${P}/"

DOCS=( ${ADIR}/AUTHORS ${ADIR}/COPYING ${ADIR}/README )

PATCHES=( "${FILESDIR}/zita-ajbridge-0.8.4_don-t-compress-and-install-manpages.patch" )

src_compile() {
	tc-export CXX
	export PREFIX="/usr"
	default
}

src_install() {
	doman *.1
	default
}
