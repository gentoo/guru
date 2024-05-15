# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit meson xdg python-single-r1

DESCRIPTION="GNOME's main interface to configure various aspects of the desktop"
HOMEPAGE="https://github.com/GradienceTeam/Gradience"
SRC_URI="https://github.com/GradienceTeam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}"/Gradience-${PV}

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	>=net-libs/libsoup-3.2.0:3.0
	dev-libs/gobject-introspection
	dev-util/blueprint-compiler
	dev-lang/sassc
"

DEPEND="
	${PYTHON_DEPS}
	x11-themes/hicolor-icon-theme
	>=gui-libs/gtk-4.5.0:4
	>=gui-libs/libadwaita-1.2:1=
	$(python_gen_cond_dep '
		>=dev-python/pygobject-3.42.2:3[${PYTHON_USEDEP}]
		>=dev-python/anyascii-0.3[${PYTHON_USEDEP}]
		dev-python/material-color-utilities[${PYTHON_USEDEP}]
		dev-python/svglib[${PYTHON_USEDEP}]
		dev-python/yapsy[${PYTHON_USEDEP}]
		dev-python/cssutils[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
	')
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/appstream-test-ignore.patch
)

src_prepare() {
	default
	xdg_environment_reset
}

src_install() {
	meson_src_install
	python_optimize
	mv "${ED}"/usr/share/appdata "${ED}"/usr/share/metainfo || die
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
