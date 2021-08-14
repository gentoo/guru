# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="py.test fixture for benchmarking code "
HOMEPAGE="
	https://pypi.python.org/pypi/pytest-benchmark
	https://github.com/ionelmc/pytest-benchmark
"
SRC_URI="https://github.com/ionelmc/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( AUTHORS.rst CHANGELOG.rst README.rst )

RDEPEND="dev-python/py-cpuinfo[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/aspectlib[${PYTHON_USEDEP}]
	dev-python/freezegun[${PYTHON_USEDEP}]
	dev-python/hunter[${PYTHON_USEDEP}]
	dev-python/pygal[${PYTHON_USEDEP}]
	dev-python/pygaljs[${PYTHON_USEDEP}]
	$(python_gen_cond_dep \
		'dev-python/elasticsearch-py[${PYTHON_USEDEP}]' python3_8 python3_9 )
)"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme

python_prepare() {
	if [[ ${EPYTHON} == python3.10 ]]; then
		rm tests/test_elasticsearch_storage.py || die
	fi
}

python_test() {
	local -x PYTHONPATH="${S}/tests:${BUILD_DIR}/lib:${PYTHONPATH}"
	local epytest_args=(
		-o markers=benchmark
		--deselect tests/test_cli.py::test_help
		--deselect tests/test_cli.py::test_help_compare
	)

	epytest "${epytest_args[@]}"
}
