# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="A double-entry accounting system that uses text files as input"
HOMEPAGE="https://beancount.github.io https://github.com/beancount/beancount"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/bottle[${PYTHON_USEDEP}]
		dev-python/chardet[${PYTHON_USEDEP}]
		dev-python/google-api-python-client[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/ply[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	')
"

EPYTEST_DESELECT=( scripts/setup_test.py )

distutils_enable_tests pytest

src_prepare() {
	sed "/def find_repository_root/a\    return '${S}'" \
		-i ${PN}/utils/test_utils.py || die
	sed "s/\[PROGRAM\]/['${EPYTHON}', PROGRAM]/" \
		-i ${PN}/tools/treeify_test.py || die
	sed "/DATA_DIR =/c\    DATA_DIR = '${S}/${PN}/utils/file_type_testdata'" \
		-i ${PN}/utils/file_type_test.py || die
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile

	# keep in sync with hashsrc.py, otherwise expect test failures
	cp beancount/parser/{lexer.l,grammar.y,decimal.h,decimal.c,macros.h,parser.h,parser.c,tokens.h} "${BUILD_DIR}"/install$(python_get_sitedir)/${PN}/parser || die
}

python_test(){
	cd "${T}" || die
	epytest --pyargs ${PN}
}

src_test() {
	emake ctest
	distutils-r1_src_test
}
