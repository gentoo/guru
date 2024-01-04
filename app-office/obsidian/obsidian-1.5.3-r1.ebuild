# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_VERSION="102"
CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"
inherit chromium-2 desktop linux-info unpacker xdg

DESCRIPTION="A second brain, for you, forever."
HOMEPAGE="https://obsidian.md/"

# For some reason, the main binary tarballs don't include the .desktop file or
# icon. The .deb does. One would hope then, that we could just download the .deb
# for each arch, but they only generate a .deb for amd64. Maybe we can get them
# to fix this, but in the meantime, we download the .deb purely to get the
# .desktop file and app icon out of it.
SRC_URI="
	https://github.com/obsidianmd/obsidian-releases/releases/download/v${PV}/${P/-/_}_amd64.deb -> ${P}.gh.deb
	amd64? ( https://github.com/obsidianmd/obsidian-releases/releases/download/v${PV}/${P}.tar.gz -> ${P}-amd64.tar.gz )
	arm64? ( https://github.com/obsidianmd/obsidian-releases/releases/download/v${PV}/${P}-arm64.tar.gz )
"

RESTRICT="mirror strip bindist"

LICENSE="Obsidian-EULA"

SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="appindicator"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret[crypt]
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
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
	appindicator? ( dev-libs/libayatana-appindicator )
"

DIR="/opt/${PN^}"

# deb gets extracted to WORKDIR. actual program gets extracted to its own dir
# which depends on CPU arch.
S="${WORKDIR}"

QA_PREBUILT="*"

CONFIG_CHECK="~USER_NS"

set_obsidian_src_dir() {
	if use amd64; then
		S_OBSIDIAN="${WORKDIR}/${P}"
	elif use arm64; then
		S_OBSIDIAN="${WORKDIR}/${P}-arm64"
	else
		die "Obsidian only supports amd64 and arm64"
	fi
}

src_configure() {
	default
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default
	# cleanup languages
	set_obsidian_src_dir
	pushd "${S_OBSIDIAN}/locales/" >/dev/null || die "location change for language cleanup failed"
	chromium_remove_language_paks
	popd >/dev/null || die "location reset for language cleanup failed"

	# Create separate .desktop file for launching Obsidian with native wayland
	# support.
	#
	# Obsidian is an Electron app, and Electron can be instructed to run in
	# native-wayland mode by turning on the Ozone platform. However, doing this
	# causes Obsidian to crash on some users' systems, while it works fine for
	# others. (see https://bugs.gentoo.org/915899)
	#
	# It appears VSCode may have encountered a similar issue, because VSCode
	# installs two separate .desktop files, one for launching with wayland
	# support and one for launching without. We will do the same here.

	# Create a copy of upstream's .desktop
	cp usr/share/applications/obsidian.desktop \
		usr/share/applications/obsidian-wayland.desktop \
		|| die "failed to create obsidian-wayland.desktop file"

	# Edit the Exec & Name
	sed -i \
		'
			# Add Electron ozone enable flags to obsidian execution
			/Exec/s/obsidian /obsidian --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations /

			# Give this .desktop file a new name/desc of "Obsidian Wayland"
			/^Name/s/$/ Wayland/

			# comment field
			/^Comment/s/$/ with Wayland support enabled/
		' \
		'usr/share/applications/obsidian-wayland.desktop' ||
		die "sed failed for obsidian-wayland.desktop file"
}

src_install() {
	insinto "${DIR}"
	exeinto "${DIR}"

	set_obsidian_src_dir
	pushd "${S_OBSIDIAN}" >/dev/null || die "location change for main install failed"

	doexe obsidian chrome-sandbox libEGL.so libffmpeg.so libGLESv2.so libvk_swiftshader.so libvulkan.so.1
	doins chrome_100_percent.pak chrome_200_percent.pak icudtl.dat resources.pak snapshot_blob.bin \
		v8_context_snapshot.bin vk_swiftshader_icd.json
	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fowners root "${DIR}/chrome-sandbox"
	fperms 4711 "${DIR}/chrome-sandbox"

	[[ -x chrome_crashpad_handler ]] && doins chrome_crashpad_handler

	popd >/dev/null || die "location reset for main install failed"

	dosym "${DIR}/obsidian" "/usr/bin/obsidian"

	if use appindicator; then
		dosym ../../usr/lib64/libayatana-appindicator3.so "${DIR}/libappindicator3.so"
	fi

	domenu usr/share/applications/obsidian.desktop
	domenu usr/share/applications/obsidian-wayland.desktop

	for size in 16 32 48 64 128 256 512; do
		doicon --size ${size} usr/share/icons/hicolor/${size}x${size}/apps/${PN}.png
	done
}

pkg_postinst() {
	xdg_icon_cache_update

	ewarn "Some users have reported that running Obsidian with native Wayland"
	ewarn "support causes the software to crash. Others have it working"
	ewarn "without issue. See https://bugs.gentoo.org/915899"
	ewarn ""
	ewarn "This package now provides application entries for both Obsidian and"
	ewarn "Obsidian Wayland. If Obsidian Wayland breaks for you under Wayland,"
	ewarn "try the other Obsidian entry to launch with XWayland"
}
