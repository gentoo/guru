# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
inherit gnome2-utils meson python-single-r1 xdg

MY_PN="Wike"
DESCRIPTION="Wikipedia Reader for the GNOME Desktop"
HOMEPAGE="https://github.com/hugolabe/Wike"
SRC_URI="https://github.com/hugolabe/${MY_PN}/archive/${PV}/${P}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	$(python_gen_cond_dep '
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]')
	gui-libs/gtk:4
	gui-libs/libadwaita:1
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
