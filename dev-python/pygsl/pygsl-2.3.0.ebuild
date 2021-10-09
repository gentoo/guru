# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Python interface for the GNU scientific library (gsl)"
HOMEPAGE="http://pygsl.sourceforge.net/ https://pypi.org/project/pygsl/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${P}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

# This is a mess
RESTRICT="test"
IUSE="examples"

DEPEND="
	sci-libs/gsl
	dev-python/numpy[${PYTHON_USEDEP}]
"

distutils_enable_sphinx doc dev-python/sphinx_rtd_theme
distutils_enable_tests nose

python_configure() {
	esetup.py config
	default
}

python_install_all() {
	use examples && dodoc -r examples
	default
}
