# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
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
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	>=dev-python/mypy-1.3.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pytest-7.0.0[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.11[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( ${PN} )
distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# circumvents our test setup by calling "pytest"; do the test manually
		pytest_mypy_plugins/tests/test_explicit_configs.py
	)
	distutils-r1_python_test

	local config= testfile="${S}"/pytest_mypy_plugins/tests/test-mypy-config.yml

	for config in pytest_mypy_plugins/tests/test_configs/*{1,2}.toml; do
		epytest --mypy-pyproject-toml-file "${config}" "${testfile}"
	done
	for config in pytest_mypy_plugins/tests/test_configs/*.{ini,cfg}; do
		epytest --mypy-ini-file "${config}" "${testfile}"
	done
}
