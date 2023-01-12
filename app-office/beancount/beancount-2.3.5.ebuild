# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
DITUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1

DESCRIPTION="A double-entry accounting system that uses text files as input"
HOMEPAGE="https://beancount.github.io https://github.com/beancount/beancount"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/${PN}-2.3.3-disable-network-tests.patch"
	"${FILESDIR}/${PN}-2.3.3-disable-tmp-access-tests.patch"
	"${FILESDIR}/${PN}-2.3.3-disable-install-test.patch"
)

RDEPEND="$(python_gen_cond_dep '
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	>=dev-python/bottle-0.12[${PYTHON_USEDEP}]
	dev-python/google-auth-oauthlib[${PYTHON_USEDEP}]
	>=dev-python/google-api-python-client-1.8.2[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.10[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.0[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-4.0[${PYTHON_USEDEP}]
	>=dev-python/ply-3.4[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/python-magic-0.4.12[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0[${PYTHON_USEDEP}]
')"

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
	cp beancount/parser/{lexer.l,grammar.y,decimal.h,decimal.c,macros.h,parser.h,parser.c,tokens.h} \
	   "${BUILD_DIR}"/lib/${PN}/parser || die
}

python_test(){
	emake ctest

	cd "${T}" || die
	epytest --pyargs ${PN}
}
