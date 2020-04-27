# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg desktop

DESCRIPTION="The Open Source next-gen Web Editor based on the rendering engine of Firefox"
HOMEPAGE="https://github.com/therealglazou/bluegriffon http://www.bluegriffon.org/"
SRC_URI="http://bluegriffon.org/freshmeat/${PV}/bluegriffon-${PV}.Ubuntu18.04-x86_64.tar.bz2 -> ${P}.tar.bz2
http://bluegriffon.org/BG_files/bluegriffon.png -> ${PN}.png"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
S="${WORKDIR}/bluegriffon/"
XDG_ECLASS_DESKTOPFILES="${FILESDIR}"
XDG_ECLASS_ICONFILES="${FILESDIR}"

BUNDLED_DEPEND="dev-libs/nspr
		dev-libs/nss"
DEPEND=">=sys-libs/glibc-2.30-r8"
RDEPEND="${DEPEND}
	${BUNDLED_DEPEND}
	x11-libs/gtk+:2
	virtual/opengl
	x11-libs/cairo
	x11-libs/pango
	dev-libs/gobject-introspection
	x11-libs/libxcb
	x11-libs/libXrender
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXau
	x11-libs/libXdmcp
	media-libs/freetype
	x11-libs/libxcb
	x11-libs/pixman
	media-libs/libpng:0/16
	sys-apps/util-linux
	media-libs/harfbuzz:0/0.9.18
	dev-libs/fribidi
	dev-libs/libffi:0/7
	dev-libs/libpcre
	dev-libs/expat
	media-gfx/graphite2
	dev-libs/libbsd"
BDEPEND=""

src_install() {
	dodir /opt/bluegriffon
	cp -ap "${S}"/* "${D}"/opt/bluegriffon/
	dosym ../../opt/bluegriffon/bluegriffon-bin /usr/bin/bluegriffon-bin
	doicon "${DISTDIR}/bluegriffon-bin.png"
	domenu "${FILESDIR}/bluegriffon-bin.desktop"
}
