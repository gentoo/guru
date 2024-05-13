# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

M_PN=r2modman

inherit desktop xdg

DESCRIPTION="A simple and easy to use mod manager for several games using Thunderstore"
HOMEPAGE="https://github.com/ebkr/r2modmanPlus"
SRC_URI="
	https://github.com/ebkr/${M_PN}Plus/releases/download/v${PV}/${M_PN}-${PV}.tar.gz -> ${P}.tar.gz
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/16x16.png -> ${P}-16x16.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/32x32.png -> ${P}-32x32.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/48x48.png -> ${P}-48x48.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/64x64.png -> ${P}-64x64.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/96x96.png -> ${P}-96x96.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/128x128.png -> ${P}-128x128.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/192x192.png -> ${P}-192x192.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/256x256.png -> ${P}-256x256.png
"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	net-dns/c-ares
	media-video/ffmpeg[alsa]
	x11-libs/gtk+[cups]
	net-libs/http-parser
	dev-libs/libappindicator
	dev-libs/libevent
	x11-libs/libnotify
	media-libs/libvpx
	dev-libs/libxslt
	x11-libs/libXScrnSaver
	x11-libs/libxkbcommon
	sys-libs/zlib[minizip]
	dev-libs/nss
	dev-libs/re2
	app-arch/snappy
"

QA_PREBUILT="
	/opt/r2modman/chrome-sandbox
	/opt/r2modman/libEGL.so
	/opt/r2modman/libGLESv2.so
	/opt/r2modman/libffmpeg.so
	/opt/r2modman/libvk_swiftshader.so
	/opt/r2modman/libvulkan.so
	/opt/r2modman/r2modman
	/opt/r2modman/swiftshader/libEGL.so
	/opt/r2modman/swiftshader/libGLESv2.so
"

src_install() {
	# Install binaries file
	mv "${M_PN}-${PV}" "${M_PN}" || die #Fix folder name
	insinto /opt
	doins -r "${M_PN}"
	fperms 755 "/opt/${M_PN}/r2modman"
	dosym -r /opt/r2modman/r2modman /usr/bin/r2modman

	#Install License file in proper location
	find "${ED}" -name "LICENSE*" -delete || die

	# Install desktop file
	domenu "${FILESDIR}/${M_PN}".desktop

	# Install icons
	for size in 16 32 48 64 96 128 192 256; do
		newicon -s ${size} "${DISTDIR}"/${P}-${size}x${size}.png ${M_PN}.png
	done
}
