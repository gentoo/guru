# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Hunter is a flexible code tracing toolkit"
HOMEPAGE="
	https://github.com/ionelmc/python-hunter
	https://pypi.org/project/hunter
"
SRC_URI="https://github.com/ionelmc/python-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python-${P}"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]"
DEPEND="dev-python/cython[${PYTHON_USEDEP}]"
BDEPEND="
	>=dev-python/setuptools_scm-3.3.1[${PYTHON_USEDEP}]
	test? (
		dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/ipdb[${PYTHON_USEDEP}]
		dev-python/manhole[${PYTHON_USEDEP}]
		dev-python/process-tests[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
	)
"

DOCS=( AUTHORS.rst CHANGELOG.rst README.rst )
PATCHES=( "${FILESDIR}/remove-setuptools_scm-upper-constraint.patch" )

distutils_enable_tests pytest
distutils_enable_sphinx docs ">=dev-python/sphinx-py3doc-enhanced-theme-2.3.2"

python_compile() {
	# native extension build fails with python3.10
	# https://github.com/ionelmc/python-hunter/issues/104
	if [[ ${EPYTHON} == python3.10 ]]; then
		SETUPPY_NOEXT="yes" distutils-r1_python_compile
		return
	fi

	distutils-r1_python_compile
	if use test; then
		"${EPYTHON}" tests/setup.py build_ext --force --inplace || die
	fi
}

python_test() {
	local PUREPYTHONHUNTER
	local -x PYTHONPATH="${S}/tests:${BUILD_DIR}/lib:${PYTHONPATH}"
	local epytest_args=(
		--deselect tests/test_remote.py::test_gdb
		--deselect tests/test_remote.py::test_gdb_clean_exit
		--deselect tests/test_remote.py::test_manhole
		--deselect tests/test_remote.py::test_manhole_clean_exit
	)

	if [[ ${EPYTHON} == python3.10 ]]; then
		epytest_args+=(
			--deselect tests/test_cookbook.py::test_probe
			--deselect tests/test_tracer.py::test_perf_filter[pure]
			--deselect tests/test_tracer.py::test_perf_stdlib[pure]
			--deselect tests/test_tracer.py::test_perf_actions[pure]
			--deselect tests/test_tracer.py::test_proper_backend
		)
		PUREPYTHONHUNTER="yes"
	fi

	epytest "${epytest_args[@]}"
}
