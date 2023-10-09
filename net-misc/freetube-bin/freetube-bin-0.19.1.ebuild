# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="A private YouTube desktop client"
HOMEPAGE="https://freetubeapp.io/ https://github.com/FreeTubeApp/FreeTube"
SRC_URI="https://github.com/FreeTubeApp/FreeTube/releases/download/v${PV}-beta/freetube_${PV}_amd64.deb"

S=${WORKDIR}

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="
	/opt/FreeTube/freetube
	/opt/FreeTube/libEGL.so
	/opt/FreeTube/libffmpeg.so
	/opt/FreeTube/libGLESv2.so
	/opt/FreeTube/libvulkan.so*
	/opt/FreeTube/chrome_crashpad_handler
	/opt/FreeTube/chrome-sandbox
	/opt/FreeTube/libvk_swiftshader.so
	/opt/FreeTube/swiftshader/libEGL.so
	/opt/FreeTube/swiftshader/libGLESv2.so
"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
"

src_install() {
	insinto /opt
	doins -r opt/*

	domenu usr/share/applications/freetube.desktop
	doicon -s scalable usr/share/icons/hicolor/scalable/apps/freetube.svg

	fperms 4755 /opt/FreeTube/chrome-sandbox || die
	fperms +x  /opt/FreeTube/freetube || die

	dosym -r /opt/FreeTube/freetube /usr/bin/freetube-bin
}
