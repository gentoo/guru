# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1

DESCRIPTION="Python bindings for dev-libs/olm"
HOMEPAGE="https://gitlab.matrix.org/matrix-org/olm/"
SRC_URI="https://gitlab.matrix.org/matrix-org/olm/-/archive/${PV}/olm-${PV}.tar.bz2"
S="${WORKDIR}/olm-${PV}/python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/olm"
RDEPEND="
	${DEPEND}
	$(python_gen_cond_dep '
		dev-python/cffi[${PYTHON_USEDEP}]
	' 'python*')
"
BDEPEND="
	test? ( dev-python/aspectlib[${PYTHON_USEDEP}] )
"

EPYTEST_DESELECT=(
	# disable benchmarks
	tests/group_session_test.py::TestClass::test_encrypt
	tests/group_session_test.py::TestClass::test_decrypt
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/alabaster
