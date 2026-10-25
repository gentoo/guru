# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RPM_COMPRESS_TYPE="xz"

inherit desktop rpm xdg

DESCRIPTION="Open-source gaming platform and launcher"
HOMEPAGE="https://github.com/hydralauncher/hydra"
SRC_URI="amd64? ( https://github.com/hydralauncher/hydra/releases/download/v${PV}/hydralauncher-${PV}.x86_64.rpm )"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"
QA_PREBUILT="*"

# native modules (classic-level, sharp) are abi-coupled to the bundled
# electron, so a system electron binary cannot be used
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

	# strip non-linux-x64 and musl prebuilds from classic-level
	local pb=opt/Hydra/resources/app.asar.unpacked/node_modules/classic-level/prebuilds
	find "${pb}" -mindepth 1 -maxdepth 1 -type d ! -name linux-x64 -exec rm -rf {} + || die
	rm -rf "${pb}"/linux-x64/*.musl.node || die

	# strip musl variants from sharp
	local sharp_base=opt/Hydra/resources/app.asar.unpacked/node_modules/@img
	rm -rf "${sharp_base}"/*-linuxmusl-x64 || die
}

src_install() {
	insinto /opt
	doins -r opt/Hydra

	# restore executable bits stripped by doins
	while IFS= read -r -d '' exe; do
		fperms +x "/${exe}"
	done < <(find opt/Hydra -type f -executable -print0)

	# chrome-sandbox requires setuid root for electron's sandbox
	fowners root "/opt/Hydra/chrome-sandbox"
	fperms 4711 "/opt/Hydra/chrome-sandbox"

	domenu usr/share/applications/hydralauncher.desktop
	doicon -s 512 usr/share/icons/hicolor/512x512/apps/hydralauncher.png

	# expose bundled libs to the bundled electron runtime
	exeinto /usr/bin
	newexe - hydralauncher <<-'EOF'
		#!/bin/sh
		export LD_LIBRARY_PATH="/opt/Hydra:${LD_LIBRARY_PATH}"
		exec /opt/Hydra/hydralauncher "$@"
	EOF
}
