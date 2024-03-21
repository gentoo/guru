# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Argotlunar is a sound granulator. Binary Linux VST"
HOMEPAGE="https://mourednik.github.io/argotlunar/"
SLOT="0"
KEYWORDS="~amd64"

QA_PRESTRIPPED="/usr/lib64/vst/${PN}/argotlunar.so"
SRC_URI="https://www.dropbox.com/s/fwtg6jfkzakj7is/argotlunar-2.06-linux_64.tar.gz -> ${P}.tar.gz"
#It's impossible to obtain package directly from DROPBOX, so I've just uploaded it to my own webserver
LICENSE="GPL-2"

RDEPEND="
	app-arch/bzip2
	dev-libs/libbsd
	media-libs/alsa-lib
	media-libs/freetype:2
	media-libs/libpng:0/16
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libxcb
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/argotlunar-${PV}-linux_64"
src_install(){
	into "/usr/$(get_libdir)/vst/${PN}"
	dolib.so argotlunar.so
	insinto "/usr/$(get_libdir)/vst/${PN}"
	doins presets.bank
	dodoc 'argotlunar2-reference.pdf'
}
