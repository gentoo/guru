# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 xdg

DESCRIPTION="Fast and simple image viewer based on Python and GTK"
HOMEPAGE="https://gitlab.com/thomasross/mirage/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/thomasross/mirage.git"
else
	SRC_URI="https://gitlab.com/thomasross/mirage/-/archive/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

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
