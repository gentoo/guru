# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python interface for the GNU scientific library (gsl)"
HOMEPAGE="https://github.com/pygsl/pygsl"
SRC_URI="https://github.com/pygsl/pygsl/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="examples"
# Tests are also failing upstream
# https://github.com/pygsl/pygsl/issues/15
RESTRICT="test"

DEPEND="
	sci-libs/gsl
	dev-python/numpy[${PYTHON_USEDEP}]
"

distutils_enable_sphinx doc dev-python/sphinx-rtd-theme
distutils_enable_tests unittest

python_configure() {
	esetup.py config
	default
}

src_install() {
	use examples && dodoc -r examples
	distutils-r1_src_install
}
