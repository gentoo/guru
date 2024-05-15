# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 toolchain-funcs

DESCRIPTION="A double-entry accounting system that uses text files as input"
HOMEPAGE="
	https://beancount.github.io
	https://github.com/beancount/beancount
"
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
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

EPYTEST_DESELECT=( scripts/setup_test.py )

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# remove test deps from 'install_requires'
	sed "/pytest/d" -i setup.py || die

	# we'll regenerate C sources
	rm ${PN}/parser/grammar.{c,h} || die
	rm ${PN}/parser/lexer.{c,h} || die

	# repair tests
	sed "/def find_repository_root/a\    return '${S}'" \
		-i ${PN}/utils/test_utils.py || die
	sed "s/\[PROGRAM\]/['${EPYTHON}', PROGRAM]/" \
		-i ${PN}/tools/treeify_test.py || die
	sed "/DATA_DIR =/c\    DATA_DIR = '${S}/${PN}/utils/file_type_testdata'" \
		-i ${PN}/utils/file_type_test.py || die
}

src_configure() {
	tc-export CC
}

python_compile() {
	distutils-r1_python_compile

	# keep in sync with hashsrc.py, otherwise expect test failures
	local csources=(
		decimal.{c,h}
		grammar.y
		lexer.l
		macros.h
		parser.{c,h}
		tokens.h
	)

	for file in "${csources[@]}"; do
		cp ${PN}/parser/${file} "${BUILD_DIR}"/install$(python_get_sitedir)/${PN}/parser || die
	done
}

src_compile() {
	local mymakeflags=(
		PYCONFIG="$(python_get_PYTHON_CONFIG)"
	)

	emake "${mymakeflags[@]}" ${PN}/parser/grammar.c
	emake "${mymakeflags[@]}" ${PN}/parser/lexer.c

	distutils-r1_src_compile

	use test && \
		emake "${mymakeflags[@]}" ${PN}/parser/tokens_test
}

python_test(){
	cd "${T}" || die
	epytest --pyargs ${PN}
}

src_test() {
	local mymakeflags=(
		PYCONFIG="$(python_get_PYTHON_CONFIG)"
	)

	emake "${mymakeflags[@]}" ctest
	distutils-r1_src_test
}
