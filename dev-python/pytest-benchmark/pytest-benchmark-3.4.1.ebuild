# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

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
	dev-python/pytest[${PYTHON_USEDEP}]
"
BDEPEND="test? (
	dev-python/aspectlib[${PYTHON_USEDEP}]
	dev-python/elasticsearch-py[${PYTHON_USEDEP}]
	dev-python/freezegun[${PYTHON_USEDEP}]
	dev-python/hunter[${PYTHON_USEDEP}]
	dev-python/pygal[${PYTHON_USEDEP}]
	dev-python/pygaljs[${PYTHON_USEDEP}]
	dev-python/pytest-xdist[${PYTHON_USEDEP}]
)" # tests include pytest-xdist integration

EPYTEST_DESELECT=(
	tests/test_cli.py::test_help
	tests/test_cli.py::test_help_compare

	# test failures with pytest7, see:
	# https://github.com/ionelmc/pytest-benchmark/issues/214
	tests/test_benchmark.py::test_groups
	tests/test_benchmark.py::test_group_by_func
	tests/test_benchmark.py::test_group_by_fullfunc
	tests/test_benchmark.py::test_group_by_param_all
	tests/test_benchmark.py::test_group_by_param_select
	tests/test_benchmark.py::test_group_by_param_select_multiple
	tests/test_benchmark.py::test_group_by_fullname
	tests/test_benchmark.py::test_only_override_skip
	tests/test_benchmark.py::test_fixtures_also_skipped
	tests/test_benchmark.py::test_max_time_min_rounds
	tests/test_benchmark.py::test_max_time
	tests/test_benchmark.py::test_disable_gc
	tests/test_benchmark.py::test_custom_timer
	tests/test_benchmark.py::test_sort_by_mean
	tests/test_benchmark.py::test_basic
	tests/test_benchmark.py::test_skip
	tests/test_benchmark.py::test_disable
	tests/test_benchmark.py::test_mark_selection
	tests/test_benchmark.py::test_only_benchmarks
)

distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme

python_test() {
	local -x PYTHONPATH="${S}/tests:${BUILD_DIR}/lib:${PYTHONPATH}"
	epytest -o markers=benchmark
}
