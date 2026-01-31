# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop rpm xdg

DESCRIPTION="Open-source gaming platform and launcher"
HOMEPAGE="https://github.com/hydralauncher/hydra"
SRC_URI="amd64? ( https://github.com/hydralauncher/hydra/releases/download/v${PV}/hydralauncher-${PV}.x86_64.rpm )"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
QA_PREBUILT="*"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/mesa
	net-misc/aria2
	net-print/cups
	sys-apps/dbus
	virtual/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/pango"

src_prepare() {
	default
	local pb=opt/Hydra/resources/app.asar.unpacked/node_modules/classic-level/prebuilds
	find "${pb}" -mindepth 1 -maxdepth 1 -type d ! -name linux-x64 -exec rm -rf {} \; || die
	rm -f "${pb}"/linux-x64/classic-level.musl.node || die
}

src_install() {
	insinto /opt
	doins -r opt/Hydra

	find opt/Hydra -type f -executable | while IFS= read -r exe; do
		fperms +x "/${exe}"
	done

	fowners root "/opt/Hydra/chrome-sandbox"
	fperms 4711 "/opt/Hydra/chrome-sandbox"

	domenu usr/share/applications/hydralauncher.desktop
	doicon -s 512 usr/share/icons/hicolor/512x512/apps/hydralauncher.png

	exeinto /usr/bin
	newexe - hydralauncher <<-'EOF'
		#!/bin/sh
		export LD_LIBRARY_PATH="/opt/Hydra:\${LD_LIBRARY_PATH}"
		exec /opt/Hydra/hydralauncher "\$@"
	EOF
}
