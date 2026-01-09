# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg-utils

DESCRIPTION="A unique, open source launcher that allows you to play your favorite Minecraft mods, and keep them up to date, all in one neat little package."
HOMEPAGE="https://modrinth.com/app"
SRC_URI="https://launcher-files.modrinth.com/versions/${PV}/linux/Modrinth%20App_${PV}_amd64.deb"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Tauri deps
RDEPEND="
	sys-apps/dbus
	dev-libs/openssl
	net-libs/webkit-gtk:4.1
	x11-libs/gtk+:3
	net-libs/libsoup
	gnome-base/librsvg
	dev-libs/glib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
"
# Minecraft deps
RDEPEND+="
	x11-libs/libX11
	media-libs/libpulse
	x11-libs/libXxf86vm
"
BDEPEND="app-arch/unzip"

QA_PREBUILT=".*"

PATCHES=(
	"${FILESDIR}/${PN}-desktop.patch"
)

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	mv "${S}/usr/share/applications/Modrinth App.desktop"\
		"${S}/usr/share/applications/${PN}.desktop"

	default

	mv "${S}/usr/bin/ModrinthApp" "${S}/usr/bin/${PN}" || die
}

src_install() {
	ICONDIR="usr/share/icons/hicolor"
	DESTDIR="/opt/${PN}"

	doicon -s 128 "${ICONDIR}/128x128/apps/ModrinthApp.png"
	doicon -s 256 "${ICONDIR}/256x256@2/apps/ModrinthApp.png"

	domenu "${S}/usr/share/applications/${PN}.desktop"

	dodir /opt/${PN}

	exeinto "${DESTDIR}"
	doexe "${S}/usr/bin/${PN}"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
