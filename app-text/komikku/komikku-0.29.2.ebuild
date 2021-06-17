# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="Komikku"
MY_P="${MY_PN}-${PV}"

PYTHON_COMPAT=( python3_{8,9} )

inherit python-single-r1 meson gnome2-utils xdg

DESCRIPTION="An online/offline manga reader for GNOME"
HOMEPAGE="https://gitlab.com/valos/Komikku"
SRC_URI="https://gitlab.com/valos/${MY_PN}/-/archive/v${PV}/${MY_PN}-v${PV}.tar.gz -> ${P}.tar.gz"

RESTRICT="test"
KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	>=gui-libs/libhandy-1.2.0
	>=x11-libs/gtk+-3.24.10
	$(python_gen_cond_dep '
		dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
		dev-python/cloudscraper[${PYTHON_USEDEP}]
		dev-python/dateparser[${PYTHON_USEDEP}]
		dev-python/keyring[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pure-protobuf[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/unidecode[${PYTHON_USEDEP}]
	')
"
RDEPEND="
	${PYTHON_DEPS}
	${DEPEND}
"

S="${WORKDIR}/${MY_PN}-v${PV}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	meson_src_install
	python_optimize

	# Dirty hack (python_doscript doesn't work)
	echo "#!/usr/bin/${EPYTHON}
	$(cat ${D}/usr/bin/${PN})" > "${D}/usr/bin/${PN}"
}

pkg_preinst() {
	gnome2_schemas_savelist
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_pkg_postrm
}
