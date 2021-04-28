# Copyright 1999-2021 Gentoo Authors
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

BUNDLED_DEPEND="
	dev-libs/nspr
	dev-libs/nss
"

DEPEND="sys-libs/glibc"

RDEPEND="
	${DEPEND}
	${BUNDLED_DEPEND}
	dev-libs/dbus-glib
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/gobject-introspection
	dev-libs/libbsd
	dev-libs/libffi:0/7
	dev-libs/libpcre
	media-gfx/graphite2
	media-libs/freetype
	media-libs/harfbuzz:0/0.9.18
	media-libs/libpng:0/16
	sys-apps/util-linux
	virtual/opengl
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/pango
	x11-libs/pixman
"

QA_PREBUILT="/opt/bluegriffon/*"

src_install() {
	dodir /opt/bluegriffon
	cp -ap "${S}"/* "${ED}"/opt/bluegriffon/ || die
	dosym ../../opt/bluegriffon/bluegriffon-bin /usr/bin/bluegriffon-bin
	doicon "${DISTDIR}/bluegriffon-bin.png"
	domenu "${FILESDIR}/bluegriffon-bin.desktop"
}
