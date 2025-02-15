# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="Easily connect your device to eduroam®."
HOMEPAGE="https://www.easyroam.de/"
SRC_URI="https://packages.easyroam.de/repos/easyroam-desktop/pool/main/e/easyroam-desktop/easyroam_connect_desktop-${PV}+${PV}-linux.deb"

QA_FLAGS_IGNORED=".*"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

PATCHES=(
	# easyroam desktop ships a malformed .desktop file, this patch fixes that
	"${FILESDIR}"/0001-fix-desktop-file.patch
)

RDEPEND="
	dev-libs/glib
	x11-libs/gtk+
	x11-libs/pango
	x11-libs/cairo
	media-libs/harfbuzz
	app-crypt/libsecret
	net-misc/networkmanager
	net-libs/webkit-gtk:4.1[keyring]
	net-libs/libsoup:3.0
	net-libs/glib-networking
"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		"s/Exec=easyroam_connect_desktop/Exec=\/usr\/share\/easyroam_connect_desktop\/easyroam_connect_desktop/" \
		"${S}/usr/share/applications/easyroam_connect_desktop.desktop"
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
