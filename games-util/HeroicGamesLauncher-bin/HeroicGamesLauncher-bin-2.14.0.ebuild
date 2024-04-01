# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg
SRC_URI="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v${PV}/heroic-${PV}.tar.xz"
DESCRIPTION="A Native GOG and Epic Games Launcher for Linux, Windows and Mac."
HOMEPAGE="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="gamescope? ( gui-wm/gamescope )"

KEYWORDS="~amd64"

S="${WORKDIR}/heroic-${PV}"

IUSE="gamescope"

QA_PREBUILT="
	opt/heroic/chrome-sandbox
	opt/heroic/chrome_crashpad_handler
	opt/heroic/heroic
	opt/heroic/libEGL.so
	opt/heroic/libGLESv2.so
	opt/heroic/libffmpeg.so
	opt/heroic/libvk_swiftshader.so
	opt/heroic/libvulkan.so.1
	opt/heroic/resources/app.asar.unpacked/build/bin/linux/gogdl
	opt/heroic/resources/app.asar.unpacked/build/bin/linux/legendary
	opt/heroic/resources/app.asar.unpacked/build/bin/linux/nile
	opt/heroic/resources/app.asar.unpacked/build/bin/linux/vulkan-helper
	opt/heroic/resources/app.asar.unpacked/node_modules/register-scheme/build/Release/register-protocol-handler.node
	opt/heroic/resources/app.asar.unpacked/node_modules/register-scheme/build/Release/node-addon-api/src/nothing.a
	opt/heroic/resources/app.asar.unpacked/node_modules/register-scheme/build/Release/nothing.a
"

src_install() {
	mv "${S}" "${WORKDIR}/heroic"
	insinto /opt
	doins -r "${WORKDIR}/heroic"
	insinto /opt/bin
	doins "${FILESDIR}/heroic"
	fperms +x /opt/heroic/heroic /opt/bin/heroic

	#fix login error both EPIC and GOG
	fperms +x /opt/heroic/resources/app.asar.unpacked/build/bin/linux/legendary \
		/opt/heroic/resources/app.asar.unpacked/build/bin/linux/gogdl \
		/opt/heroic/resources/app.asar.unpacked/build/bin/linux/nile

	domenu "${FILESDIR}/HeroicGamesLauncher.desktop"
	newicon "${WORKDIR}/heroic/resources/app.asar.unpacked/build/icon.png" heroic.png
	if use gamescope; then
		#Start Heroic as gamescope window
		domenu "${FILESDIR}/HeroicGamesLauncher-gamescope.desktop"
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
