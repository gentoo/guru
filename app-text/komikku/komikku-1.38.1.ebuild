# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="sqlite(+),ssl(+)"
DISTUTILS_USE_PEP517=no
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 meson gnome2-utils xdg

DESCRIPTION="Manga reader for GNOME"
HOMEPAGE="https://apps.gnome.org/Komikku/"
SRC_URI="https://codeberg.org/valos/Komikku/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

KEYWORDS="~amd64"
LICENSE="GPL-3+"
SLOT="0"
IUSE="test"

RESTRICT="test"
# Depend on a random server that may or may not be accessible at all times.
#PROPERTIES="test_network"

DEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	>=gui-libs/gtk-4.12.1:4
	>=gui-libs/libadwaita-1.4:1[introspection]
	net-libs/webkit-gtk:6[introspection]
"
RDEPEND="
	${DEPEND}
	x11-libs/libnotify[introspection]
	$(python_gen_cond_dep '
		app-arch/brotli[python,${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/colorthief[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/dateparser[${PYTHON_USEDEP}]
		dev-python/emoji[${PYTHON_USEDEP}]
		dev-python/keyring[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/natsort[${PYTHON_USEDEP}]
		dev-python/piexif[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pure-protobuf[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/rarfile[compressed,${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/unidecode[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	dev-util/blueprint-compiler
	sys-devel/gettext
	test? (
		$(python_gen_cond_dep '
			dev-python/pytest-steps[${PYTHON_USEDEP}]
		')
	)
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# fix broken shebang
	sed "s|py_installation.full_path()|'${PYTHON}'|" -i bin/meson.build || die
}

src_test() {
	emake setup
	emake develop
	emake test
}

src_install() {
	meson_src_install
	python_optimize
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
