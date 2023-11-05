# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit desktop unpacker xdg

DESCRIPTION="Opensource IDE For Exploring and Testing Api's"
HOMEPAGE="
	https://www.usebruno.com/
	https://github.com/usebruno/bruno
"
SRC_URI="https://github.com/usebruno/${PN%-*}/releases/download/v${PV}/${PN%-*}_${PV}_amd64_linux.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fontconfig cups alsa dbus accessibility"

RDEPEND="
	dev-libs/glib
	dev-libs/nss
	dev-libs/nspr
	app-accessibility/at-spi2-core
	x11-libs/libdrm
	x11-libs/gtk+
	x11-libs/pango
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	media-libs/mesa
	dev-libs/expat
	x11-libs/libxcb
	x11-libs/libxkbcommon
	sys-devel/gcc
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	dbus? ( sys-apps/dbus )
	fontconfig? ( media-libs/fontconfig:1.0 )
	accessibility? ( app-accessibility/at-spi2-core )
"

S="$WORKDIR"

src_install() {
	for size in 16x16 32x32 48x48 128x128 256x256 512x512 1024x1024; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}"/apps/bruno.png
	done
	dosym ../icons/hicolor/512x512/apps/bruno.png \
		/usr/share/pixmaps/bruno.png

	domenu usr/share/applications/bruno.desktop

	insinto /opt/Bruno
	doins -r opt/Bruno/.
	fperms +x /opt/Bruno/bruno
	fperms +x /opt/Bruno/chrome-sandbox
	fperms +x /opt/Bruno/chrome_crashpad_handler
	dosym ../Bruno/bruno opt/bin/bruno
}
