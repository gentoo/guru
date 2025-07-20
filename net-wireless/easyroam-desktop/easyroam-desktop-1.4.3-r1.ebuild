# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg-utils

MY_PN="easyroam_connect_desktop"

DESCRIPTION="Easily connect your device to eduroam®"
HOMEPAGE="https://www.easyroam.de"
SRC_URI="https://packages.easyroam.de/repos/easyroam-desktop/pool/main/e/easyroam-desktop/${MY_PN}-${PV}+${PV}-linux.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/glib
	media-libs/harfbuzz
	net-misc/networkmanager
	net-libs/glib-networking
	net-libs/libsoup:3.0
	net-libs/webkit-gtk:4.1[keyring]
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
"
DEPEND="${RDEPEND}"

QA_PREBUILT="
	/usr/share/${MY_PN}/${MY_PN}
	/usr/share/${MY_PN}/lib/*
"
src_prepare() {
	# correct the version
	sed -i "s/${PV}/1.0/g" "${S}"/usr/share/applications/${MY_PN}.desktop
	sed -i \
		"s/Exec=${MY_PN}/Exec=\/usr\/share\/${MY_PN}\/${MY_PN}/" \
		"${S}/usr/share/applications/${MY_PN}.desktop"
	default
}

src_install() {
	mv "${S}/usr" "${D}/"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
