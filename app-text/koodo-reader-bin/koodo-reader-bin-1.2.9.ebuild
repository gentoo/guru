# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm xdg desktop
DESCRIPTION="A modern ebook manager and reader with sync and backup capacities"
HOMEPAGE="https://koodo.960960.xyz/"
SRC_URI="https://github.com/troyeguo/koodo-reader/releases/download/v1.2.9/Koodo.Reader-1.2.9.rpm"

S="${WORKDIR}"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrandr
	media-libs/alsa-lib
	dev-libs/atk
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	net-print/cups
	x11-libs/libdrm
	media-libs/mesa
	x11-libs/gtk+
	x11-libs/gdk-pixbuf
	dev-libs/nss
	x11-libs/pango
	x11-libs/libxkbcommon
"
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="opt/*"
src_install(){
	insinto /opt
	doins -r "${S}"/opt/Koodo\ Reader
	dosym ../../opt/Koodo\ Reader/koodo-reader "${EPREFIX}/usr/bin/koodo-reader"
	fperms +x /opt/Koodo\ Reader/koodo-reader
	insinto /usr
	doins -r "${S}"/usr/share
	doins -r "${S}"/usr/lib
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
pkg_postrm(){
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
