# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
PYTHON_REQ_USE="sqlite(+),ssl(+)"
DISTUTILS_USE_PEP517=no
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 meson gnome2-utils xdg

DESCRIPTION="Manga reader for GNOME"
HOMEPAGE="https://apps.gnome.org/Komikku/"
SRC_URI="https://codeberg.org/valos/Komikku/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="CC0-1.0 CC-BY-4.0 GPL-3+ OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="test"
# Depend on a random server that may or may not be accessible.
#PROPERTIES="test_network"

DEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	>=gui-libs/gtk-4.18:4
	>=gui-libs/libadwaita-1.8:1[introspection]
	net-libs/webkit-gtk:6[introspection]
"
RDEPEND="
	${DEPEND}
	$(python_gen_cond_dep '
		>=app-arch/brotli-1.2.0[python,${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/modern-colorthief[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/dateparser[${PYTHON_USEDEP}]
		dev-python/emoji[${PYTHON_USEDEP}]
		dev-python/keyring[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/natsort[${PYTHON_USEDEP}]
		dev-python/piexif[${PYTHON_USEDEP}]
		>=dev-python/pillow-11.3.0[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		>=dev-python/pyjwt-2.10.1[${PYTHON_USEDEP}]
		>=dev-python/pypdf-6.4.2[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/rarfile[compressed,${PYTHON_USEDEP}]
		>=dev-python/requests-2.32.4[${PYTHON_USEDEP}]
		dev-python/unidecode[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	dev-util/blueprint-compiler
	sys-devel/gettext
"

PATCHES=(
	# x11-libs/gdk-pixbuf-2.44.3 is not packaged yet
	"${FILESDIR}/${P}-revert-pixbuf-2.44.3.patch"
)

EPYTEST_PLUGINS=( pytest-steps )
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
