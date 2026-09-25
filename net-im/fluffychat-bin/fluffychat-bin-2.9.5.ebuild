# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# I hope this will be only a temporary ebuild until I have time to add flutter and/or dart so we can build it from source

EAPI=8

inherit wrapper

DESCRIPTION="The cutest instant messenger in the [matrix]"
HOMEPAGE="https://fluffychat.im/ https://github.com/krille-chan/fluffychat"
SRC_URI="https://github.com/krille-chan/fluffychat/releases/download/v${PV}/fluffychat-linux-x64.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip test"

QA_PREBUILT="*"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/harfbuzz
	media-libs/libepoxy
	media-libs/mesa
	net-libs/libsoup:3.0
	net-libs/webkit-gtk:4.1
	virtual/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/pango
"

src_install() {
	insinto /opt/fluffychat
	doins -r data lib

	exeinto /opt/fluffychat
	doexe fluffychat

	make_wrapper "fluffychat" "/opt/fluffychat/fluffychat"
}
