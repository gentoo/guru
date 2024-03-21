# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )

inherit meson xdg python-single-r1

DESCRIPTION="GNOME's main interface to configure various aspects of the desktop"
HOMEPAGE="https://github.com/GradienceTeam/Gradience"
SRC_URI+="https://dev.gentoo.org/~mattst88/distfiles/${PN}-42.0-patchset.tar.xz"
SRC_URI="https://github.com/GradienceTeam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

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
	>=dev-python/pygobject-3.42.2:3
	>=dev-python/anyascii-0.3
	dev-python/material-color-utilities
	dev-python/svglib
	dev-python/yapsy
	dev-python/cssutils
	dev-python/jinja
	dev-python/aiohttp
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/Gradience-${PV}

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
