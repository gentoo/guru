# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="A second brain, for you, forever."
HOMEPAGE="https://obsidian.md/"
SRC_URI="https://github.com/obsidianmd/obsidian-releases/releases/download/v${PV}/${P/-/_}_amd64.deb -> ${P}.gh.deb"

LICENSE="Obsidian-EULA"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
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
	x11-libs/pango
"

DIR="/opt/${PN^}"
S="${WORKDIR}"

QA_PREBUILT="${DIR#/}/chrome-sandbox
   ${DIR#/}/chrome_crashpad_handler
   ${DIR#/}/libGLESv2.so
   ${DIR#/}/libEGL.so
   ${DIR#/}/libffmpeg.so
   ${DIR#/}/libvk_swiftshader.so
   ${DIR#/}/libvulkan.so.1
   ${DIR#/}/obsidian
   ${DIR#/}/resources/app.asar.unpacked/node_modules/*
"

src_install() {
	insinto ${DIR}
	doins -r ${DIR#/}/*

	domenu usr/share/applications/obsidian.desktop

	for size in 16 32 48 64 128 256 512; do
		doicon --size ${size} usr/share/icons/hicolor/${size}x${size}/apps/${PN}.png
	done

	fperms 4755 ${DIR}/chrome-sandbox
	fperms +x  ${DIR}/obsidian

	dosym -r ${DIR}/obsidian /usr/bin/obsidian
}
