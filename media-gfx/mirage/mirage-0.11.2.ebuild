# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 xdg

DESCRIPTION="Fast and simple image viewer based on Python and GTK"
HOMEPAGE="https://gitlab.com/thomasross/mirage/"
SRC_URI="https://gitlab.com/thomasross/mirage/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pygobject-3.29.3[${PYTHON_USEDEP},cairo]
	>=dev-python/pycairo-1.0.0[${PYTHON_USEDEP}]
	>=media-libs/gexiv2-0.10[introspection]
	>=media-gfx/exiv2-0.27
	>=x11-libs/gtk+-3.24.0:3[introspection]
"
DEPEND="
	${RDEPEND}
	x11-libs/libX11
"
BDEPEND="
	dev-util/glib-utils
	sys-devel/gettext
"

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
