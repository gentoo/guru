# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="P2P file sharing system"
HOMEPAGE="https://www.fopnu.com"
SRC_URI="https://download2.fopnu.com/download/${P}-1.x86_64.manualinstall.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}-1.x86_64.manualinstall"

LICENSE="Fopnu"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib
	sys-apps/dbus
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
"
DEPEND="${RDEPEND}"

src_install() {
	sed -i "/^Categories/ s/Internet;//" fopnu.desktop

	dobin fopnu
	domenu fopnu.desktop
	doicon -s 48 fopnu.png
}
