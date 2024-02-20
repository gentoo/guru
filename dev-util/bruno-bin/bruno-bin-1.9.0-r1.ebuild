# Copyright 2023-2024 Gentoo Authors
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

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	dev-libs/wayland
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-devel/gcc:=
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb:=
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="
	opt/Bruno/bruno
	opt/Bruno/chrome-sandbox
	opt/Bruno/chrome_crashpad_handler
	opt/Bruno/libEGL.so
	opt/Bruno/libGLESv2.so
	opt/Bruno/libffmpeg.so
	opt/Bruno/libvk_swiftshader.so
	opt/Bruno/libvulkan.so.1
"

S="$WORKDIR"

src_prepare() {
	default
	rm opt/Bruno/LICENSE* || die
}

src_install() {
	for size in 16x16 32x32 48x48 128x128 256x256 512x512 1024x1024; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}"/apps/bruno.png
	done
	dosym -r /usr/share/icons/hicolor/512x512/apps/bruno.png \
		/usr/share/pixmaps/bruno.png

	domenu usr/share/applications/bruno.desktop

	insinto /opt/Bruno
	doins -r opt/Bruno/.
	fperms +x /opt/Bruno/bruno
	fperms +x /opt/Bruno/chrome-sandbox
	fperms +x /opt/Bruno/chrome_crashpad_handler
	dosym -r /opt/Bruno/bruno /usr/bin/bruno
}
