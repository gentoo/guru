# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="Komikku"
MY_P="${MY_PN}-${PV}"

PYTHON_COMPAT=( python3_{7,8} )

DISTUTILS_USE_SETUPTOOLS=no
inherit distutils-r1 meson gnome2-utils xdg

DESCRIPTION="An online/offline manga reader for GNOME"
HOMEPAGE="https://gitlab.com/valos/Komikku"
SRC_URI="https://gitlab.com/valos/${MY_PN}/-/archive/v${PV}/${MY_PN}-v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

# Requires network connection to test
RESTRICT="test"

DEPEND="
	>=gui-libs/libhandy-0.0.10:0.0/0
	>=x11-libs/gtk+-3.24.10
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/cloudscraper[${PYTHON_USEDEP}]
	dev-python/dateparser[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pure-protobuf[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${MY_PN}-v${PV}"

distutils_enable_tests pytest

src_install() {
	meson_src_install
	python_foreach_impl python_optimize
}

src_test() {
	PYTHONPATH="${S}:${PYTHONPATH}" python_foreach_impl python_test
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
