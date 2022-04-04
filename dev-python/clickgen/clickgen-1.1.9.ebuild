# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1 toolchain-funcs

DESCRIPTION="X11 & Windows cursor building API"
HOMEPAGE="https://github.com/ful1e5/clickgen https://pypi.org/project/clickgen/"
SRC_URI="https://github.com/ful1e5/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/libpng
	x11-libs/libX11
	x11-libs/libXcursor
"
RDEPEND="${DEPEND}
	dev-python/pillow[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}"/${PN}-flags.patch )

distutils_enable_tests pytest

distutils_enable_sphinx docs/source dev-python/sphinx_rtd_theme

src_configure() {
	distutils-r1_src_configure
	tc-export CC
}

python_compile() {
	emake -C xcursorgen
	distutils-r1_python_compile
}
