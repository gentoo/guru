# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# NOTICE: This is a Electron app (oh my) and the upstream only provides AppImages.

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop xdg

# To check the latest version, run:
#
# 	curl -s "https://api.beeper.com/desktop/update-feed.json?bundleID=com.automattic.beeper.desktop&platform=linux&arch=x64&channel=stable" | jq .version

APPIMAGE="Beeper-${PV}.AppImage"
DESCRIPTION="Beeper: Unified Messenger"
HOMEPAGE="https://www.beeper.com/"
SRC_URI="https://beeper-desktop.download.beeper.com/builds/${APPIMAGE}"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="4"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libayatana-appindicator
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	virtual/udev
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXtst
	x11-libs/libdrm
	x11-libs/libnotify
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="*"

pkg_pretend() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	mkdir -p "${S}" || die
	cp "${DISTDIR}/${APPIMAGE}" "${S}" || die

	cd "${S}" || die	# "appimage-extract" unpacks to current directory.
	chmod +x "${S}/${APPIMAGE}" || die
	"${S}/${APPIMAGE}" --appimage-extract || die
}

src_prepare() {
	default

	# Fix permissions.
	find "${S}" -type d -exec chmod a+rx {} + || die
	find "${S}" -type f -exec chmod a+r {} + || die

	cd squashfs-root/locales || die
	chromium_remove_language_paks
}

src_install() {
	cd "${S}/squashfs-root" || die

	insinto /usr/share
	doins -r ./usr/share/icons

	local apphome="/opt/BeeperTexts"
	local -a toremove=(
		.DirIcon
		AppRun
		LICENSE.electron.txt
		LICENSES.chromium.html
		beepertexts.desktop
		beepertexts.png
		resources/app/node_modules/classic-level/prebuilds/linux-x64/classic-level.musl.node
		usr
	)
	rm -f -r "${toremove[@]}" || die

	mkdir -p "${ED}/${apphome}" || die
	cp -r . "${ED}/${apphome}" || die

	dosym -r "${apphome}"/beepertexts /usr/bin/beepertexts
	make_desktop_entry "beepertexts" Beeper beepertexts "Network;" \
		"StartupWMClass=Beeper\nMimeType=x-scheme-handler/beeper;"
}
