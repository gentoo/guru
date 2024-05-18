# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk vi zh-CN zh-TW
"

inherit chromium-2 linux-info unpacker optfeature xdg

DESCRIPTION="Session Desktop - Onion routing based messenger"
HOMEPAGE="https://getsession.org/ https://github.com/oxen-io/session-desktop"
SRC_URI="https://github.com/oxen-io/session-desktop/releases/download/v${PV}/session-desktop-linux-amd64-${PV}.deb"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="splitdebug"

RDEPEND="
		|| (
			>=app-accessibility/at-spi2-core-2.46.0:2
		)
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	dev-libs/wayland
	media-libs/alsa-lib
	media-libs/mesa[X(+)]
	net-print/cups
	sys-apps/dbus[X]
	x11-libs/cairo
	x11-libs/gtk+:3[X]
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/pango
"
DESTDIR="/opt/${MY_PN}"

QA_PREBUILT="
	${DESTDIR#/}/session-desktop
	${DESTDIR#/}/chrome_crashpad_handler
	${DESTDIR#/}/chrome-sandbox
	${DESTDIR#/}/libffmpeg.so
	${DESTDIR#/}/libvk_swiftshader.so
	${DESTDIR#/}/libvulkan.so.1
	${DESTDIR#/}/libEGL.so
	${DESTDIR#/}/libGLESv2.so
	${DESTDIR#/}/libVkICD_mock_icd.so
	${DESTDIR#/}/swiftshader/libEGL.so
	${DESTDIR#/}/swiftshader/libGLESv2.so
	${DESTDIR#/}/resources/app.asar.unpacked/node_modules/*
"

CONFIG_CHECK="~USER_NS"

pkg_pretend(){
	chromium_suid_sandbox_check_kernel_config
}

src_unpack(){
	default
	unpack ../work/data.tar.xz
	unpack ../work/usr/share/doc/session-desktop/changelog.gz
}

src_prepare(){
	default

	pushd "opt/Session/locales/" >/dev/null || die "location change for language cleanup failed"
	chromium_remove_language_paks
	popd > /dev/null || die "location reset for language cleanup failed"

	sed -i 's|/opt/Session/session-desktop|/opt/session-desktop/session-desktop|g' \
		"${S}/usr/share/applications/session-desktop.desktop" || die "error changing .desktop file"
}

src_configure(){
	default
	chromium_suid_sandbox_check_kernel_config
}

src_install(){
	insinto /
	dodoc changelog

	insinto /usr/share
	doins -r usr/share/applications
	doins -r usr/share/icons

	pushd "opt/Session/" > /dev/null || die "change dir failed"

	exeinto "${DESTDIR}"
	doexe "${MY_PN}" chrome-sandbox libEGL.so libGLESv2.so libvk_swiftshader.so libffmpeg.so

	insinto "${DESTDIR}"
	doins chrome_100_percent.pak chrome_200_percent.pak icudtl.dat resources.pak snapshot_blob.bin v8_context_snapshot.bin
	insopts -m0755
	doins -r  locales resources swiftshader

	popd > /dev/null || die "change dir reset failed"

	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	dosym -r "${DESTDIR}/${MY_PN}" "/usr/bin/${MY_PN}"
}

pkg_postinst(){
	xdg_pkg_postinst

	optfeature "sound support" \
		media-sound/pulseaudio media-sound/apulse[sdk] media-video/pipewire
	optfeature "system tray support" dev-libs/libappindicator
}
