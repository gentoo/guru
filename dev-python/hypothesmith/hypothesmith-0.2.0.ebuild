# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 ) # python3_11 depends on dev-python/libcst

inherit distutils-r1 pypi

DESCRIPTION="Hypothesis strategies for generating Python programs"
HOMEPAGE="https://github.com/Zac-HD/hypothesmith"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

src_prepare() {
	default
	sed -e '/-Werror/d' \
		-e '/--cov/d' \
		-i tox.ini || die
}

RDEPEND="
	>=dev-python/hypothesis-5.41.0[${PYTHON_USEDEP}]
	>=dev-python/lark-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/libcst-0.3.8[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/parso[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests --install pytest

python_test() {
	# https://github.com/Zac-HD/hypothesmith/issues/21
	local EPYTEST_DESELECT=( 'tests/test_cst.py::test_source_code_from_libcst_node_type' )
	epytest
}
