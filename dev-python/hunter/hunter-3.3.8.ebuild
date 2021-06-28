# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..9} )

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
DEPEND="
	${RDEPEND}
	test? (
		dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/ipdb[${PYTHON_USEDEP}]
		dev-python/manhole[${PYTHON_USEDEP}]
		dev-python/process-tests[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	>=dev-python/setuptools_scm-3.3.1[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/remove-setuptools_scm-upper-constraint.patch" )

distutils_enable_tests pytest
distutils_enable_sphinx docs ">=dev-python/sphinx-py3doc-enhanced-theme-2.3.2"

python_compile() {
	distutils-r1_python_compile

	if use test; then
		"${EPYTHON}" tests/setup.py build_ext --force --inplace || die
	fi
}

python_test() {
	local -x PYTHONPATH="${S}/tests:${BUILD_DIR}/lib:${PYTHONPATH}"
	epytest -vv \
		--deselect tests/test_remote.py::test_manhole \
		--deselect tests/test_remote.py::test_manhole_clean_exit \
		|| die
}
