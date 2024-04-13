# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop unpacker xdg

# To check the latest version, run:
#
# 	curl https://download.todesktop.com/2003241lzgn20jd/latest-linux.yml

BUILD_ID="240411hw9xbpc7s"
DESCRIPTION="Beeper: Unified Messenger"
HOMEPAGE="https://www.beeper.com/"
SRC_URI="https://download.todesktop.com/2003241lzgn20jd/${P}-build-${BUILD_ID}-amd64.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="appindicator"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
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
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libnotify
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-misc/xdg-utils
	appindicator? ( dev-libs/libayatana-appindicator )
"

QA_PREBUILT="*"

pkg_pretend() {
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default

	cd opt/Beeper/locales || die
	chromium_remove_language_paks
}

src_install() {
	domenu usr/share/applications/beeper.desktop
	for size in {16,32,48,64,128,256,512,1024}; do
		doicon -s ${size} usr/share/icons/hicolor/${size}x${size}/apps/beeper.png
	done

	local DESTDIR="/opt/Beeper"
	cd opt/Beeper || die

	exeinto "${DESTDIR}"
	doexe beeper chrome-sandbox *.so*
	[[ -x chrome_crashpad_handler ]] && \
		doexe chrome_crashpad_handler

	insinto "${DESTDIR}"
	doins *.pak *.bin *.json *.dat
	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fperms 4755 "${DESTDIR}"/chrome-sandbox

	# https://bugs.gentoo.org/898912
	if use appindicator; then
		dosym -r /usr/lib64/libayatana-appindicator3.so "${DESTDIR}"/libappindicator3.so
	fi
}
