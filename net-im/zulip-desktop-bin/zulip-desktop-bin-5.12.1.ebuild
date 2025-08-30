# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop unpacker xdg

DESCRIPTION="Organized chat for distributed teams."
HOMEPAGE="https://zulip.com/"
SRC_URI="
	amd64? ( https://download.zulip.com/desktop/apt/pool/main/z/zulip/Zulip-${PV}-amd64.deb )
"

S="${WORKDIR}"

LICENSE="
	MIT BSD BSD-2 BSD-4 AFL-2.1 Apache-2.0 Ms-PL GPL-2 LGPL-2.1 APSL-2
	unRAR OFL-1.1 CC-BY-SA-3.0 MPL-2.0 android public-domain all-rights-reserved
"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
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
	sys-libs/zlib
"

QA_PREBUILT="opt/Zulip/*"

pkg_pretend() {
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	# cleanup languages
	pushd "opt/Zulip/locales" || die
	chromium_remove_language_paks
	popd || die
}

src_configure() {
	chromium_suid_sandbox_check_kernel_config
	default
}

src_install() {
	# why does this release only have one icon size?!?
	size=512
	doicon -s ${size} "usr/share/icons/hicolor/${size}x${size}/apps/zulip.png"

	domenu usr/share/applications/zulip.desktop

	local DESTDIR="/opt/Zulip"
	pushd "opt/Zulip" || die

	exeinto "${DESTDIR}"
	doexe chrome-sandbox chrome_crashpad_handler zulip *.so*

	insinto "${DESTDIR}"
	doins *.pak *.bin *.json *.dat
	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fperms 4755 "${DESTDIR}"/chrome-sandbox

	dosym "${DESTDIR}"/zulip /opt/bin/zulip
	popd || die
}
