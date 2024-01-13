# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
FORTRAN_NEEDED="fortran"
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 cmake flag-o-matic fortran-2

DESCRIPTION="MUlticomponent Thermodynamic And Transport library for IONized gases"
HOMEPAGE="https://github.com/mutationpp/Mutationpp"
SRC_URI="https://github.com/mutationpp/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="LGPL-3"
SLOT="0/${PV}"
IUSE="doc fortran python test"

RDEPEND="
	dev-cpp/eigen
	python? (
		${PYTHON_DEPS}
		dev-python/numpy[${PYTHON_USEDEP}]
	)
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/catch:0 )
	python? (
		dev-python/pybind11[${PYTHON_USEDEP}]
		>=dev-python/scikit-build-0.11.1[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	app-alternatives/ninja
	dev-util/cmake
	doc? ( app-text/doxygen )
	python? ( ${DISTUTILS_DEPS} )
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DOCS=( {README,CHANGELOG}.md docs )
PATCHES=(
	"${FILESDIR}/${P}-system-libs.patch"
	"${FILESDIR}/${P}-respect-flags.patch"
)

distutils_enable_tests pytest

src_prepare() {
	rm -r thirdparty || die
	cmake_src_prepare
	use python && python_prepare_all
}

src_configure() {
	append-cxxflags "-I${EPREFIX}/usr/include/catch2"
	local mycmakeargs=(
		-DENABLE_COVERAGE=OFF

		-DBUILD_DOCUMENTATION=$(usex doc)
		-DBUILD_FORTRAN_WRAPPER=$(usex fortran)
		-DBUILD_PYTHON_WRAPPER=$(usex python)
		-DENABLE_TESTING=$(usex test)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use python && python_foreach_impl distutils-r1_python_compile
}

src_install() {
	cmake_src_install
	use python && python_foreach_impl distutils-r1_python_install
	insinto "/usr/share/${PN}"
	doins -r data
	echo MPP_DIRECTORY="/usr/share/${PN}" > "99${PN}"
	echo MPP_DATA_DIRECTORY="/usr/share/${PN}/data" >> "99${PN}"
	doenvd "99${PN}"
}

src_test() {
	export MPP_DIRECTORY="."
	export MPP_DATA_DIRECTORY="${MPP_DATA_DIRECTORY}/data"
	cmake_src_test
	use python && python_foreach_impl distutils-r1_python_test
}
