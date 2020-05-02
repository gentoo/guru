# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="Komikku"
MY_P="${MY_PN}-${PV}"

PYTHON_COMPAT=( python3_7 )

inherit meson python-single-r1 gnome2-utils xdg

DESCRIPTION="An online/offline manga reader for GNOME"
HOMEPAGE="https://gitlab.com/valos/Komikku"
SRC_URI="https://gitlab.com/valos/${MY_PN}/-/archive/v${PV}/${MY_PN}-v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	>=gui-libs/libhandy-0.0.10
	>=x11-libs/gtk+-3.24.10
	dev-python/beautifulsoup:4
	dev-python/cloudscraper
	dev-python/dateparser
	dev-python/lxml
	dev-python/pillow
	dev-python/pure-protobuf
	dev-python/python-magic
	dev-python/unidecode
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${MY_PN}-v${PV}"

src_install() {
	meson_src_install
	python_optimize
}

pkg_preinst() {
	gnome2_schemas_savelist
	xdg_environment_reset
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
