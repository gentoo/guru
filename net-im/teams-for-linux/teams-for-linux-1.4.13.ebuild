# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop rpm xdg

DESCRIPTION="Unofficial Microsoft Teams client for Linux. Binary precompiled version."
HOMEPAGE="https://github.com/IsmaelMartinez/teams-for-linux"
SRC_URI="
	amd64? ( https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v${PV}/${P}.x86_64.rpm )
	arm? ( https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v${PV}/${P}.armv7l.rpm )
	arm64? ( https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v${PV}/${P}.aarch64.rpm )
"
S="${WORKDIR}"

KEYWORDS="-* ~amd64 ~arm ~arm64"
# Electron bundles a bunch of things
LICENSE="
	MIT BSD BSD-2 BSD-4 AFL-2.1 Apache-2.0 Ms-PL GPL-2 LGPL-2.1 APSL-2
	unRAR OFL CC-BY-SA-3.0 MPL-2.0 android public-domain all-rights-reserved
"
SLOT="0"
RESTRICT="bindist mirror"

DEPEND="
	app-accessibility/at-spi2-core
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
"

QA_PREBUILT="opt/teams-for-linux/*"

pkg_pretend() {
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	# cleanup languages
	pushd "opt/teams-for-linux/locales" || die
	chromium_remove_language_paks
	popd || die
}

src_configure() {
	chromium_suid_sandbox_check_kernel_config
	default
}

src_install() {
	for size in {16,24,32,48,64,96,128,256,512,1024}; do
		doicon -s ${size} "usr/share/icons/hicolor/${size}x${size}/apps/teams-for-linux.png"
	done

	domenu usr/share/applications/teams-for-linux.desktop

	local DESTDIR="/opt/teams-for-linux"

	pushd "opt/teams-for-linux" || die

	exeinto "${DESTDIR}"
	doexe chrome-sandbox chrome_crashpad_handler teams-for-linux *.so*

	insinto "${DESTDIR}"
	doins *.pak *.bin *.json *.dat
	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fperms 4755 "${DESTDIR}"/chrome-sandbox

	dosym "${DESTDIR}"/teams-for-linux /opt/bin/teams-for-linux
	popd || die
}
