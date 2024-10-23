# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg unpacker optfeature
DESCRIPTION="A desktop client for IPFS. The IPFS's Native Application"
HOMEPAGE="https://github.com/ipfs-shipyard/ipfs-desktop"
SRC_URI="https://github.com/ipfs/ipfs-desktop/releases/download/v${PV}/ipfs-desktop-${PV}-linux-amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
x11-libs/gtk+:3
x11-libs/libnotify
dev-libs/nss
x11-libs/libXScrnSaver
x11-libs/libXtst
x11-misc/xdg-utils
app-accessibility/at-spi2-core
sys-apps/util-linux
app-crypt/libsecret
net-p2p/kubo
"
RDEPEND="${DEPEND}"
S="${WORKDIR}"
pkg_postinst(){
	xdg_pkg_postinst
	optfeature "cli interface" net-p2p/kubo
}
pkg_postrm(){
	xdg_pkg_postrm
}
src_prepare(){
default
	unpacker "${S}/usr/share/doc/ipfs-desktop/changelog.gz"
	# to prevent ipfs-desktop install build-in ipfs exe into /usr/local/bin or ${HOME}/.local/bin
	# sed -i "s/^binpaths=\(.*\)$/binpaths=\'\/usr\/bin\'/" "${S}/opt/IPFS Desktop/resources/app.asar.unpacked/node_modules/kubo/kubo/install.sh"
}
src_install(){
	# clean up build-in kubo
	insinto "/opt"
	doins -r "${S}/opt/IPFS Desktop"
	dosym -r "/opt/IPFS Desktop/ipfs-desktop" "/usr/bin/ipfs-desktop"
	domenu "${S}/usr/share/applications/ipfs-desktop.desktop"
	dodoc "${S}/changelog"
	insinto "/usr/share"
	doins -r "${S}/usr/share/icons"
	fperms +x "/opt/IPFS Desktop/ipfs-desktop"
	fperms +x "/opt/IPFS Desktop/chrome-sandbox"
	fperms +x "/opt/IPFS Desktop/chrome_crashpad_handler"
	fperms +x "/opt/IPFS Desktop/resources/app.asar.unpacked/node_modules/kubo/kubo/ipfs"
}
