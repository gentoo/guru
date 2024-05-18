# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
inherit gnome2-utils meson python-single-r1 xdg

MY_PN="Wike"
DESCRIPTION="Wikipedia Reader for the GNOME Desktop"
HOMEPAGE="https://github.com/hugolabe/Wike"
SRC_URI="https://github.com/hugolabe/${MY_PN}/archive/${PV}/${P}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/pygobject
	dev-python/requests
	gui-libs/gtk
	gui-libs/libadwaita
	net-libs/libsoup:3.0
	net-libs/webkit-gtk:6
	x11-libs/pango
	x11-themes/hicolor-icon-theme
"
BDEPEND="
	dev-libs/appstream-glib
	dev-libs/glib:2
	sys-devel/gettext
"

src_install() {
	meson_src_install
	python_fix_shebang "${D}/usr/bin/${PN}"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
