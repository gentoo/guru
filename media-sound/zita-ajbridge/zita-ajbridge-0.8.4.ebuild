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

src_prepare() {
	default
	sed -i -e "/ldconfig/d" "${S}"/Makefile || die
}

src_compile() {
	tc-export CXX
	default
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	emake DESTDIR="${D}" PREFIX=/usr install
	einstalldocs
	pushd "${D}"/usr/share/man/man1 > /dev/null
	gzip -d zita-a2j.1.gz
	gzip -d zita-ajbridge.1.gz
	gzip -d zita-j2a.1.gz
	popd > /dev/null
}
