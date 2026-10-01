# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg optfeature

DESCRIPTION="Open source voice and text chat client"
HOMEPAGE="https://fluxer.app"
SRC_URI="https://github.com/fluxerapp/fluxer/releases/download/fluxer-desktop-canary%40${PV}/Fluxer-Canary-${PV}-linux-x64.tar.gz -> ${P}.tar.gz"

RDEPEND="
	media-libs/alsa-lib
	app-accessibility/at-spi2-core
	x11-libs/cairo
	sys-apps/dbus
	dev-libs/expat
	dev-libs/glib
	x11-libs/gtk+
	app-crypt/libsecret
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	media-libs/mesa
	dev-libs/nspr
	dev-libs/nss
	x11-libs/pango
	net-print/cups
	dev-libs/openssl
	media-video/pipewire
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/Fluxer-Canary-${PV}-linux-x64"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"
DESTDIR="/opt/fluxer-canary-bin"
QA_PREBUILT="*"

src_install() {
	for size in 16 24 32 48 64 128 256 512; do
		newicon -s "${size}" "${S}"/resources/icons/${size}x${size}.png fluxer-canary-bin.png
	done

	domenu "${FILESDIR}"/fluxer-canary.desktop

	exeinto "${DESTDIR}"

	doexe fluxer-canary chrome-sandbox libffmpeg.so libvk_swiftshader.so libvulkan.so.1

	insinto "${DESTDIR}"
	doins chrome_100_percent.pak chrome_200_percent.pak icudtl.dat resources.pak \
		snapshot_blob.bin v8_context_snapshot.bin vk_swiftshader_icd.json
	insopts -m0755
	doins -r locales resources

	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	[[ -x chrome_crashpad_handler ]] && doins chrome_crashpad_handler

	dosym "${DESTDIR}/fluxer-canary" "/usr/bin/fluxer-canary-bin"
}

pkg_postinst() {
	optfeature "desktop integration" x11-misc/xdg-utils
	optfeature "system tray integration" dev-libs/libdbusmenu
	optfeature "text-to-speech" app-accessibility/speech-dispatcher
	optfeature "wayland portal integration" sys-apps/xdg-desktop-portal
	xdg_pkg_postinst
}
