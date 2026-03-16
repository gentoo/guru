# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python library for TOML"
HOMEPAGE="
	https://github.com/uiri/toml
	https://pypi.org/project/toml/
"
SRC_URI="https://github.com/uiri/toml/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"

EPYTEST_DESELECT=(
	tests/test_api.py::test_invalid_tests
	tests/test_api.py::test_valid_tests
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install

	dodoc LICENSE
}
