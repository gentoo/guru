# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
inherit distutils-r1

DESCRIPTION="A simple, correct PEP517 build frontend"
HOMEPAGE="https://github.com/pypa/build https://pypi.org/project/build/"
SRC_URI="https://github.com/pypa/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pep517[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
"
BDEPEND="test? (
	dev-python/filelock[${PYTHON_USEDEP}]
	dev-python/flaky[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

# distutils_enable_sphinx docs \
# 	dev-python/furo \
# 	dev-python/sphinx-argparse-cli \
# 	dev-python/sphinx-autodoc-typehints

EPYTEST_DESELECT=(
	tests/test_env.py::test_isolated_env_log
	tests/test_main.py::test_build_package
	tests/test_main.py::test_build_package_via_sdist
	tests/test_main.py::test_output
	tests/test_main.py::test_output_env_subprocess_error
	"tests/test_util.py::test_wheel_metadata[True]"
	tests/test_util.py::test_wheel_metadata_isolation
	tests/test_util.py::test_with_get_requires
)
