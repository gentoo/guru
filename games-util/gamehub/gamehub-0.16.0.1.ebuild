# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION="0.44"

inherit gnome2-utils meson vala xdg

DESCRIPTION="GameHub is a unified library for all your games"
HOMEPAGE="https://tkashkin.tk/projects/gamehub"

MY_PN="GameHub"
MY_PV="$(ver_rs 3 '-')-master"
MY_P="${MY_PN}-${MY_PV}"

SRC_URI="https://github.com/tkashkin/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8
	>=dev-libs/libmanette-0.2
	dev-libs/libxml2
	net-libs/libsoup:2.4
	net-libs/webkit-gtk:4
	sys-auth/polkit
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXtst"
BDEPEND="
	${RDEPEND}
	$(vala_depend)"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	vala_src_prepare
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
