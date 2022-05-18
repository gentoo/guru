# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi fr gu he hi hr hu id it 
ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW"

inherit desktop xdg unpacker chromium-2

DESCRIPTION="Desktop application for Jitsi Meet built with Electron"
HOMEPAGE="https://github.com/jitsi/jitsi-meet-electron"
SRC_URI="https://github.com/jitsi/jitsi-meet-electron/releases/download/v${PV}/jitsi-meet-amd64.deb -> ${P}.deb"

LICENSE="Apache-2.0"
SLOT="0"

IUSE="swiftshader system-ffmpeg"

RESTRICT="bindist mirror splitdebug test"

QA_PREBUILT="*"
#Depends: libgtk-3-0, libnss3, libxtst6, xdg-utils, libatspi2.0-0, libuuid1
RDEPEND="
	x11-libs/gtk+:3
	dev-libs/nss
	x11-libs/libXtst
	app-accessibility/at-spi2-core:2
	app-accessibility/at-spi2-atk:2
	system-ffmpeg? ( <media-video/ffmpeg-4.3[chromium] )
"
#	sys-libs/libuuid seems to be included in sys-apps/util-linux
#	sys-fs/fuse

KEYWORDS="~amd64"
S=$WORKDIR


src_install() {
	rm "opt/Jitsi Meet/chrome-sandbox" || die

	insinto /opt
	doins -r "opt/Jitsi Meet"

	dobin "opt/Jitsi Meet/jitsi-meet"
	dosym "${EPREFIX}/opt/Jitsi Meet/jitsi-meet" ${EPREFIX}/usr/bin/jitsi-meet
	domenu usr/share/applications/jitsi-meet.desktop
	doicon usr/share/icons/hicolor/512x512/apps/jitsi-meet.png

	pushd "${ED}/opt/Jitsi Meet/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	if use system-ffmpeg; then
		rm "${ED}/opt/Jitsi Meet/libffmpeg.so" || die
		dosym "../../usr/$(get_libdir)/chromium/libffmpeg.so" "opt/Jitsi Meet/libffmpeg.so" || die
		elog "Using system ffmpeg. This is experimental and may lead to crashes."
	fi

	if ! use swiftshader; then
		rm -r "${D}/opt/Jitsi Meet/swiftshader" || die
		elog "Running without SwiftShader OpenGL implementation. If Jitsi doesn't start "
		elog "or you experience graphic issues, then try with USE=swiftshader enabled."
	fi

	fperms +x "/opt/Jitsi Meet/jitsi-meet"
}
