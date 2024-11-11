# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson rust xdg

UPLOADHASH="4a5dcb11cec0b0438ad575db08aa755c"
DESCRIPTION="Fragments is an easy to use BitTorrent client"
HOMEPAGE="https://gitlab.gnome.org/World/Fragments"
SRC_URI="https://gitlab.gnome.org/World/${PN}/uploads/${UPLOADHASH}/${P}.tar.xz"
BUILD_DIR="${S}/build"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/glib-2.76.0:2
	>=dev-libs/openssl-1.0.0:=
	>=gui-libs/gtk-4.12.0:4
	>=gui-libs/libadwaita-1.5.0:1
	net-p2p/transmission
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/pango
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
"

# Rust package
QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
