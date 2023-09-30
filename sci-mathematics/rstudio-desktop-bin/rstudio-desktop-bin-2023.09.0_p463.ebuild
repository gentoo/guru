# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-desktop-bin/}"

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 linux-info optfeature rpm xdg

DESCRIPTION="IDE for R and Python"
HOMEPAGE="https://posit.co"
SRC_URI="https://download1.rstudio.org/electron/rhel8/x86_64/${MY_PN}-${PV/_p/-}-x86_64.rpm"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip test"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret
	app-misc/jq
	dev-db/postgresql
	dev-cpp/yaml-cpp
	dev-lang/R
	dev-libs/boost[context(+)]
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/mathjax
	dev-libs/nspr
	dev-libs/nss
	|| (
		dev-libs/openssl-compat:1.1.1
		=dev-libs/openssl-1.1.1*
	)
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	sys-libs/glibc
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
	=virtual/jdk-11*:*
"

DESTDIR="/opt/${MY_PN}"

QA_PREBUILT="
	${DESTDIR#/}/${MY_PN}
	${DESTDIR#/}/chrome-sandbox
	${DESTDIR#/}/chrome_crashpad_handler
	${DESTDIR#/}/libffmpeg.so
	${DESTDIR#/}/libvk_swiftshader.so
	${DESTDIR#/}/libvulkan.so
	${DESTDIR#/}/libEGL.so
	${DESTDIR#/}/libGLESv2.so
"

CONFIG_CHECK="~USER_NS"

S="${WORKDIR}/usr/lib/${MY_PN}"

src_configure() {
	default
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	pushd "locales/" >/dev/null || die "location change for language cleanup failed"
	chromium_remove_language_paks
	popd >/dev/null || die "location reset for language cleanup failed"
	# fix .desktop exec location
	sed -i "/Exec/s:/usr/lib/rstudio/rstudio:${DESTDIR}/${MY_PN}:" \
		"${WORKDIR}/usr/share/applications/${MY_PN}.desktop" ||
		die "fixing of exec location on .desktop failed"
}

src_install() {
	insinto "/usr"
	doins -r "${WORKDIR}/usr/share"

	exeinto "${DESTDIR}"

	doexe "${MY_PN}" chrome-sandbox chrome_crashpad_handler libEGL.so libGLESv2.so libffmpeg.so libvk_swiftshader.so libvulkan.so.1

	insinto "${DESTDIR}"
	doins chrome_100_percent.pak chrome_200_percent.pak icudtl.dat resources.pak snapshot_blob.bin v8_context_snapshot.bin vk_swiftshader_icd.json
	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	dosym "${DESTDIR}/${MY_PN}" "/usr/bin/${MY_PN}"
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "sound support" \
		media-sound/pulseaudio media-sound/apulse[sdk] media-video/pipewire
	optfeature "system tray support" dev-libs/libappindicator
}
