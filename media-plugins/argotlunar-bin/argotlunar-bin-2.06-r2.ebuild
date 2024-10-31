# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Argotlunar is a sound granulator. Binary Linux VST"
HOMEPAGE="https://mourednik.github.io/argotlunar/"
SRC_URI="https://www.dropbox.com/s/fwtg6jfkzakj7is/argotlunar-2.06-linux_64.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/argotlunar-${PV}-linux_64"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/bzip2
	dev-libs/libbsd
	media-libs/alsa-lib
	media-libs/freetype:2
	media-libs/libpng:0/16
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libxcb
"
DEPEND="${RDEPEND}"

QA_PREBUILT="*"

src_install(){
	into "/usr/$(get_libdir)/vst/${PN}"
	dolib.so argotlunar.so
	insinto "/usr/$(get_libdir)/vst/${PN}"
	doins presets.bank
	dodoc 'argotlunar2-reference.pdf'
}
