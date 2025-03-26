# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop unpacker linux-info xdg

DESCRIPTION="The CurseForge Electron App"
HOMEPAGE="https://www.curseforge.com/"
SRC_URI="
	amd64? ( https://${PN}.overwolf.com/downloads/${PN}-latest-linux.deb -> ${P}.deb )"
S="${WORKDIR}/"

LICENSE="Overwolf Apache-2.0 BSD BSD-2 GPL-2 LGPL-2+ LGPL-2.1 MPL-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip test"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libX11
	x11-libs/pango
	x11-misc/xdg-utils
"
DESTDIR="/opt/${PN}"

QA_PREBUILT="*"

CONFIG_CHECK="~USER_NS"

src_configure() {
	default
	chromium_suid_sandbox_check_kernel_config
}

src_install() {
	sed -i "s|Exec=.*|Exec=/usr/bin/${PN} %U|"  \
		"usr/share/applications/${PN}.desktop" \
		|| die "Failed correcting .desktop file"

	doicon -s 256 "usr/share/icons/hicolor/256x256/apps/${PN}.png"
	domenu "usr/share/applications/${PN}.desktop"

	exeinto "${DESTDIR}"
	cd opt/CurseForge/ || die "Failed changing directory to unpacked source"
	doexe ${PN} chrome-sandbox libEGL.so libffmpeg.so libGLESv2.so libvk_swiftshader.so libvulkan.so.1

	insinto "${DESTDIR}"
	doins chrome_100_percent.pak chrome_200_percent.pak icudtl.dat resources.pak snapshot_blob.bin v8_context_snapshot.bin
	insopts -m0755
	doins -r locales resources

	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	[[ -x chrome_crashpad_handler ]] && doins chrome_crashpad_handler

	dosym "${DESTDIR}/${PN}" "/usr/bin/${PN}"
}
