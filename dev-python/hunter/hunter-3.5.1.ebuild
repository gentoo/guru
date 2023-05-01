# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 multiprocessing

DESCRIPTION="Hunter is a flexible code tracing toolkit"
HOMEPAGE="
	https://github.com/ionelmc/python-hunter
	https://pypi.org/project/hunter/
"
SRC_URI="https://github.com/ionelmc/python-${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-${P}"
TEST_S="${S}_test"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	>=dev-python/setuptools-scm-3.3.1[${PYTHON_USEDEP}]
	test? (
		dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/ipdb[${PYTHON_USEDEP}]
		dev-python/manhole[${PYTHON_USEDEP}]
		dev-python/process-tests[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		sys-devel/gdb
	)
"

DOCS=( AUTHORS.rst CHANGELOG.rst README.rst )

EPYTEST_DESELECT=(
	# broken
	tests/test_tracer.py::test_source_cython
	tests/test_tracer.py::test_fullsource_cython

	# too unstable
	tests/test_remote.py
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	">=dev-python/sphinx-py3doc-enhanced-theme-2.3.2"

src_unpack() {
	default

	cp -a "${S}" "${TEST_S}" || die
	mv -f "${TEST_S}"/tests/setup.py "${TEST_S}"/setup.py || die
}

src_prepare() {
	default

	find . -name '*.c' -delete || die "removing csources failed"
}

python_compile() {
	distutils-r1_python_compile

	if use test; then
		einfo "  Building tests"
		cd "${TEST_S}" || die
		esetup.py build_ext -j $(makeopts_jobs) --inplace
	fi
}

python_test() {
	cd "${TEST_S}"/tests || die
	epytest
}
