# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# NOTICE: This is a Electron app (oh my) and the upstream only provides AppImages.

EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 optfeature pax-utils xdg

# To check the latest version, run:
#
# 	curl -s "https://api.beeper.com/desktop/update-feed.json?bundleID=com.automattic.beeper.desktop&platform=linux&arch=x64&channel=stable" | jq .version

APPIMAGE="Beeper-${PV}.AppImage"
DESCRIPTION="Beeper: Unified Messenger"
HOMEPAGE="https://www.beeper.com/"
SRC_URI="https://beeper-desktop.download.beeper.com/builds/${APPIMAGE}"
S="${WORKDIR}/squashfs-root"

LICENSE="all-rights-reserved"
# node_modules licenses
LICENSE+=" Apache-2.0 BSD ISC MIT"
SLOT="4"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret[crypt]
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	media-libs/vips:0/42
	net-print/cups
	sys-apps/dbus
	>=sys-libs/glibc-2.26
	virtual/udev
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="*"

src_unpack() {
	cd "${WORKDIR}" || die	# "appimage-extract" unpacks to current directory.

	cp "${DISTDIR}/${APPIMAGE}" "${WORKDIR}" || die
	chmod +x "${APPIMAGE}" || die
	./"${APPIMAGE}" --appimage-extract || die
}

src_prepare() {
	default

	# Fix permissions
	find "${S}" -type d -exec chmod a+rx {} + || die
	find "${S}" -type f -exec chmod a+r {} + || die

	# Fix desktop menu item
	sed "/^Exec=/c Exec=beepertexts %U" -i beepertexts.desktop || die

	# Handle Chromium language packs
	pushd locales || die
	chromium_remove_language_paks
	popd || die
}

src_configure() {
	default
	chromium_suid_sandbox_check_kernel_config
}

src_install() {
	# Install icons and the desktop file
	mkdir -p usr/share/applications || die
	mv beepertexts.desktop usr/share/applications || die

	insinto /usr/share
	doins -r ./usr/share/{applications,icons}

	# Cleanup
	local -a toremove=(
		.DirIcon
		AppRun
		LICENSE.electron.txt
		LICENSES.chromium.html
		beepertexts.png
		resources/app/build/main/linux-*.mjs
		resources/app/node_modules/classic-level/prebuilds/linux-x64/classic-level.musl.node
		usr
	)
	rm -r "${toremove[@]}" || die

	# Install
	local apphome="/opt/BeeperTexts"

	pax-mark m beepertexts
	mkdir -p "${ED}${apphome}" || die
	cp -r . "${ED}${apphome}" || die
	fperms 4711 "${apphome}"/chrome-sandbox

	local libvips_dest=(
		resources/app/node_modules/@img/sharp-libvips-linux-x64/lib/libvips-cpp.so.*
	)
	(( ${#libvips_dest[@]} == 1 )) ||
		die "multiple or no libvips libraries found"
	dosym -r /usr/$(get_libdir)/libvips-cpp.so.42 "${apphome}/${libvips_dest[0]}"

	dosym -r "${apphome}"/beepertexts /usr/bin/beepertexts
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "desktop notifications" x11-libs/libnotify
}
