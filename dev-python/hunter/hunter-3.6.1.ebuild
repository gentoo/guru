# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

DOCS_BUILDER="sphinx"
DOCS_DEPEND="dev-python/sphinx-py3doc-enhanced-theme"
DOCS_DIR="docs"

inherit distutils-r1 docs

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

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
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

PATCHES=(
	# Upstream uses a custom file to define backend as setuptools
	"${FILESDIR}/fix_backend.patch"
)

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# I think it needs internet
	tests/test_remote.py::test_manhole_clean_exit
	# Need a py.io module that does not seem to exist
	tests/test_util.py::test_safe_repr
	# Permission denied in a chroot
	tests/test_remote.py::test_gdb
	tests/test_remote.py::test_gdb_clean_exit
)

python_test() {
	# Need to import files in tests folder
	cd "${S}/tests" || die
	if [[ "${EPYTHON}" == "python3.12" ]]; then
		EPYTEST_DESELECT+=(
			# From what I could understand, it fail because of a change in pathlib in 3.12
			tests/test_cookbook.py::test_profile
			tests/test_integration.py::test_errorsnooper
			tests/test_integration.py::test_errorsnooper_fastmode
		)
	fi
	epytest
}

src_prepare() {
	# Need a module that does not exist (see https://github.com/ionelmc/python-hunter/issues/116)
	rm "${S}/tests/test_tracer.py" || die
	distutils-r1_src_prepare
}
