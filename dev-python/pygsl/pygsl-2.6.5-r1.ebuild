# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python interface for the GNU scientific library (gsl)"
HOMEPAGE="https://github.com/pygsl/pygsl"
SRC_URI="https://github.com/pygsl/pygsl/archive/v${PV}/${PN}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="examples"
# Tests are also failing upstream
# https://github.com/pygsl/pygsl/issues/15
RESTRICT="test"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-lang/swig
"
RDEPEND="
	sci-libs/gsl:=
	dev-python/numpy[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/numpy-casts.patch" )

EPYTEST_PLUGINS=( )

distutils_enable_sphinx doc dev-python/sphinx-rtd-theme
distutils_enable_tests pytest

src_configure() {
	# Relative paths don't work in this case, so we give it a full path
	sed -i "s|'-I../typemaps'|'-I${S}/typemaps'|" meson.build \
		|| die "Failed to patch typemaps"
	distutils-r1_src_configure
}

src_install() {
	use examples && dodoc -r examples
	distutils-r1_src_install
}
