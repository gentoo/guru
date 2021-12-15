# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

MY_PN="${PN}-python"
DESCRIPTION="A Thrift encoding library for Python"
HOMEPAGE="
	https://github.com/thriftrw/thriftrw-python
	https://pypi.org/project/thriftrw
"
SRC_URI="https://github.com/thriftrw/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"

# broken tests
RESTRICT="test"

RDEPEND="dev-python/ply[${PYTHON_USEDEP}]"
BDEPEND="
	>=dev-python/cython-0.17[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pytest-benchmark-3.0.1[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${P}-no-install-examples.patch"
	"${FILESDIR}/${P}-tool-pytest.patch"
)

DOCS=( CHANGELOG.rst CONTRIBUTING.md README.rst TODO.rst )

distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/alabaster

python_prepare_all() {
	rm tests/protocol/test_binary.py || die
	distutils-r1_python_prepare_all
}

python_compile() {
	use test && esetup.py build_ext --force --inplace
	distutils-r1_python_compile
}
