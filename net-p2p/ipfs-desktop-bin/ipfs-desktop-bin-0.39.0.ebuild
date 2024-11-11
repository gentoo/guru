# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg unpacker wrapper
DESCRIPTION="A desktop client for IPFS. The IPFS's Native Application"
HOMEPAGE="https://github.com/ipfs/ipfs-desktop"
SRC_URI="https://github.com/ipfs/ipfs-desktop/releases/download/v${PV}/ipfs-desktop-${PV}-linux-amd64.deb"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libnotify
	dev-libs/nss
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	app-accessibility/at-spi2-core
	sys-apps/util-linux
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
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
	net-p2p/kubo
"
QA_PREBUILT="*"
src_prepare(){
	default
	unpacker "${S}/usr/share/doc/ipfs-desktop/changelog.gz"
}
src_install(){
	# clean up build-in kubo
	rm -r "${S}/opt/IPFS Desktop/resources/app.asar.unpacked/node_modules/kubo/kubo" || die

	insinto "/opt"
	doins -r "${S}/opt/IPFS Desktop"
	make_wrapper ipfs-desktop "env KUBO_BINARY=$(which ipfs) /opt/IPFS\\ Desktop/ipfs-desktop"
	domenu "${S}/usr/share/applications/ipfs-desktop.desktop"
	dodoc "${S}/changelog"
	insinto "/usr/share"
	# doins -r "${S}/usr/share/icons"
	local size
	for size in 16 32 48 64 128 256 512; do
		 doicon -s ${size} "${S}/usr/share/icons/hicolor/${size}x${size}/apps/ipfs-desktop.png"
	done
	fperms +x "/opt/IPFS Desktop/ipfs-desktop"
	fperms +x "/opt/IPFS Desktop/chrome-sandbox"
	fperms +x "/opt/IPFS Desktop/chrome_crashpad_handler"
}
