# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Hunter is a flexible code tracing toolkit"
HOMEPAGE="
	https://github.com/ionelmc/python-hunter
	https://pypi.org/project/hunter/
"
SRC_URI="https://github.com/ionelmc/python-${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-${P}"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

# python-hunter only works if deps are vendored (some .pth stuff)
#RDEPEND="
	#>=dev-python/colorama-0.4.4[${PYTHON_USEDEP}]
	#dev-python/cymem[${PYTHON_USEDEP}]
#"
DEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/setuptools_scm-3.3.1[${PYTHON_USEDEP}]
	test? (
		dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/ipdb[${PYTHON_USEDEP}]
		dev-python/manhole[${PYTHON_USEDEP}]
		dev-python/process-tests[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/toml[${PYTHON_USEDEP}]
	)
" # toml is an indirect dependency (needed by ipdb)

DOCS=( AUTHORS.rst CHANGELOG.rst README.rst )

EPYTEST_IGNORE=( test_remote.py )
EPYTEST_DESELECT=(
	tests/test_tracer.py::test_source_cython
	tests/test_tracer.py::test_fullsource_cython
)

distutils_enable_tests pytest

distutils_enable_sphinx docs ">=dev-python/sphinx-py3doc-enhanced-theme-2.3.2"

src_unpack() {
	default
	cp -a "${S}" tests_package || die
	mv -f tests_package/tests/setup.py tests_package || die
}

python_test() {
	cp -a "${BUILD_DIR}"/{install,test} || die
	local -x PATH=${BUILD_DIR}/test/usr/bin:${PATH}

	cd "${WORKDIR}"/tests_package >/dev/null || die
	distutils_pep517_install "${BUILD_DIR}"/test

	cd ./tests || die
	epytest
}
