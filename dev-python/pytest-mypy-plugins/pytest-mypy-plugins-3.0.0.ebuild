# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )
inherit distutils-r1

DESCRIPTION="pytest plugin for testing mypy types, stubs, plugins"
HOMEPAGE="
	https://pypi.org/project/pytest-mypy-plugins/
	https://github.com/typeddjango/pytest-mypy-plugins/
"

SRC_URI="https://github.com/typeddjango/pytest-mypy-plugins/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS="README* CHANGELOG*"

RDEPEND="
	>=dev-python/mypy-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.11[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() {
	# Calling pytest directly causes module not to be imported correctly
	sed "s/\"pytest\"/\"${EPYTHON}\", \"-m\", \"pytest\"/" \
		-i pytest_mypy_plugins/tests/test_explicit_configs.py || die
	distutils-r1_python_test
}
