# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1
# inherit pypi

DESCRIPTION="Powerful and Lightweight Python Tree Data Structure with various plugins"
HOMEPAGE="https://anytree.readthedocs.io/"

SRC_URI="https://github.com/c0fec0de/anytree/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

distutils_enable_sphinx docs
distutils_enable_tests pytest

src_prepare(){
	default

	mkdir "${S}/tests/dotexport" || die
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	cd "${S}/tests" || die
	distutils-r1_python_test
}
