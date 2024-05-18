# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
inherit cmake distutils-r1 edo

DESCRIPTION="Library for fast text representation and classification"
HOMEPAGE="https://fasttext.cc https://github.com/facebookresearch/fastText"
SRC_URI="https://github.com/facebookresearch/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	python? (
		${PYTHON_DEPS}
		dev-python/pybind11[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	python? ( ${DISTUTILS_DEPS} )
"

DOCS=( {CODE_OF_CONDUCT,CONTRIBUTING,README}.md python/{README.rst,doc} docs )
PATCHES=(
	"${FILESDIR}/${P}-gcc13.patch"
	"${FILESDIR}/${P}-pep517.patch"
)

src_prepare() {
	cmake_src_prepare
	use python && distutils-r1_src_prepare

	sed \
		-e "/CMAKE_CXX_FLAGS/d" \
		-e "s/\(DESTINATION\) lib/\1 $(get_libdir)/g" \
		-i CMakeLists.txt || die
	sed "/extra_compile_args=/,+1d" -i setup.py || die
}

src_configure() {
	local mycmakeargs=(
		-DPROJECT_VERSION=${PV}
	)

	cmake_src_configure
	use python && distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	use python && distutils-r1_src_compile
}

src_test() {
	use python && distutils-r1_src_test
}

python_test() {
	edo ${EPYTHON} runtests.py -u
}

src_install() {
	cmake_src_install
	use python && distutils-r1_src_install

	find "${ED}" -name '*.a' -delete || die
}
