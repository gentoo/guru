# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Argotlunar is a sound granulator. Binary Linux VST"
HOMEPAGE="http://mourednik.github.io/argotlunar/"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

QA_PRESTRIPPED="/usr/lib64/vst/${PN}/argotlunar.so"
SRC_URI="https://gentoodistfiles.imperium.org.ru/guru/argotlunar-bin-2.06-linux_amd64.tar.gz -> ${P}.tar.gz"
#It's impossible to obtain package directly from DROPBOX, so I've just uploaded it to my own webserver
LICENSE="GPL-2"

RDEPEND="sys-libs/glibc
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXau
	x11-libs/libXdmcp
	media-libs/freetype:2
	media-libs/alsa-lib
	app-arch/bzip2
	x11-libs/libxcb
	sys-libs/zlib
	media-libs/libpng:0/16
	dev-libs/libbsd"
DEPEND="${RDEPEND}"
S="${WORKDIR}/argotlunar-${PV}-linux_64"
src_install(){
	exeinto "/usr/$(get_libdir)/vst/${PN}"
	doexe argotlunar.so
	insinto "/usr/$(get_libdir)/vst/${PN}"
	doins presets.bank
	if use doc; then
		dodoc 'argotlunar2-reference.pdf'
		einfo "Check argotlunar2-reference.pdf into package doc folder"
	fi
}
