# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-single-r1 meson gnome2-utils virtualx xdg

MY_PN="${PN^}"
MY_P="${MY_PN}-v${PV}"
DESCRIPTION="An online/offline manga reader for GNOME"
HOMEPAGE="https://gitlab.com/valos/Komikku"
SRC_URI="https://gitlab.com/valos/${MY_PN}/-/archive/v${PV}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

KEYWORDS="~amd64"
LICENSE="GPL-3+"
SLOT="0"
IUSE="test"

RESTRICT="test"
PROPERTIES="test_network"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection[${PYTHON_SINGLE_USEDEP}]
	>=gui-libs/libhandy-1.5.0
	net-libs/webkit-gtk
	x11-libs/gtk+:3
"
RDEPEND="
	${PYTHON_DEPS}
	${DEPEND}
	$(python_gen_cond_dep '
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/cloudscraper[${PYTHON_USEDEP}]
		dev-python/dateparser[${PYTHON_USEDEP}]
		dev-python/keyring[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/natsort[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pure-protobuf[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/unidecode[${PYTHON_USEDEP}]
	')
"
BDEPEND="test? (
	${RDEPEND}
	$(python_gen_cond_dep '
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-steps[${PYTHON_USEDEP}]
	')
)"

EPYTEST_DESELECT=(
	'tests/servers/test_dankefurslesen.py::test_dankefurslesen[get_manga_data]'
	'tests/servers/test_dankefurslesen.py::test_dankefurslesen[get_chapter_data]'
	'tests/servers/test_dankefurslesen.py::test_dankefurslesen[get_page_image]'
	tests/servers/test_dynasty.py
	tests/servers/test_genkan.py::test_edelgardescans
	tests/servers/test_genkan.py::test_hatigarmscans
	'tests/servers/test_japscan.py::test_japscan[get_page_image]'
	tests/servers/test_leomanga.py
	'tests/servers/test_mangahub.py::test_mangahub[get_page_image]'
	tests/servers/test_mangakawaii.py
	tests/servers/test_mangalib.py
	tests/servers/test_mangasin.py
	tests/servers/test_nhentai.py
	'tests/servers/test_romance24h.py::test_romance24h[get_page_image]'
	tests/servers/test_scanmanga.py
	tests/servers/test_scanonepiece.py
	'tests/servers/test_wakascan.py::test_wakascan[get_manga_data]'
	'tests/servers/test_wakascan.py::test_wakascan[get_chapter_data]'
	'tests/servers/test_wakascan.py::test_wakascan[get_page_image]'
)

src_test() {
	virtx epytest
}

src_install() {
	meson_src_install
	python_optimize

	sed -i "s|#!.*|#!/usr/bin/${EPYTHON}|" "${ED}"/usr/bin/${PN}  ||
		die "Failed to fix ${ED}/usr/bin/${PN} interpreter"
}

pkg_preinst() {
	gnome2_schemas_savelist
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
