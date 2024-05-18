# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=setuptools

DOCS_BUILDER="sphinx"
DOCS_DEPEND="dev-python/sphinx-py3doc-enhanced-theme"
DOCS_DIR="docs"

inherit distutils-r1 docs

DESCRIPTION="py.test fixture for benchmarking code"
HOMEPAGE="
	https://pypi.python.org/pypi/pytest-benchmark/
	https://github.com/ionelmc/pytest-benchmark
"
SRC_URI="https://github.com/ionelmc/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {AUTHORS,CHANGELOG,README}.rst )

RDEPEND="
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/elasticsearch[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/hunter[${PYTHON_USEDEP}]
		dev-python/pygal[${PYTHON_USEDEP}]
		dev-python/pygaljs[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-vcs/git
		dev-vcs/mercurial
	)
"

EPYTEST_DESELECT=(
	# The equality test is not correct (the format changed but the tests did not)
	# This also deselect other tests for some reason
	tests/test_cli.py::test_help
	tests/test_cli.py::test_help_compare
	tests/test_benchmark.py::test_abort_broken
	tests/test_utils.py::test_clonefunc
)

distutils_enable_tests pytest
