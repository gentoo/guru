# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_IN_SOURCE_BUILD=1
CMAKE_MAKEFILE_GENERATOR="emake"
COMMIT="54c6ebe03a07d7c32db46a6a06a03e8b821da4f2"
EGO_PN="mlpack.org/v1/mlpack"
EGO_SUM=(
	"github.com/ajstarks/svgo v0.0.0-20180226025133-644b8db467af/go.mod"
	"github.com/fogleman/gg v1.2.1-0.20190220221249-0403632d5b90/go.mod"
	"github.com/golang/freetype v0.0.0-20170609003504-e2365dfdc4a0/go.mod"
	"github.com/jung-kurt/gofpdf v1.0.3-0.20190309125859-24315acbbda5/go.mod"
	"golang.org/x/exp v0.0.0-20180321215751-8460e604b9de/go.mod"
	"golang.org/x/exp v0.0.0-20180807140117-3d87b88a115f/go.mod"
	"golang.org/x/exp v0.0.0-20190125153040-c74c464bbbf2"
	"golang.org/x/exp v0.0.0-20190125153040-c74c464bbbf2/go.mod"
	"golang.org/x/image v0.0.0-20180708004352-c73c2afc3b81/go.mod"
	"golang.org/x/tools v0.0.0-20180525024113-a5b4c53f6e8b/go.mod"
	"golang.org/x/tools v0.0.0-20190206041539-40960b6deb8e/go.mod"
	"gonum.org/v1/gonum v0.0.0-20180816165407-929014505bf4/go.mod"
	"gonum.org/v1/gonum v0.7.0"
	"gonum.org/v1/gonum v0.7.0/go.mod"
	"gonum.org/v1/netlib v0.0.0-20190313105609-8cb42192e0e0"
	"gonum.org/v1/netlib v0.0.0-20190313105609-8cb42192e0e0/go.mod"
	"gonum.org/v1/plot v0.0.0-20190515093506-e2840ee46a6b/go.mod"
	"rsc.io/pdf v0.1.1/go.mod"
	)
GO_OPTIONAL=1
PYTHON_COMPAT=( python3_10 )

inherit cmake flag-o-matic go-module python-single-r1

go-module_set_globals

DESCRIPTION="scalable C++ machine learning library"
HOMEPAGE="
	https://www.mlpack.org
	https://github.com/mlpack/mlpack
"
SRC_URI="
	https://github.com/mlpack/mlpack/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz
	go? ( ${EGO_SUM_SRC_URI} )
"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-3 BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc go julia openmp profile R source test"

CDEPEND="
	${PYTHON_DEPS}
	go? ( >=dev-lang/go-1.11.0 )
	julia? ( || ( >=dev-lang/julia-1.3.0 >=dev-lang/julia-bin-1.3.0:* ) )
	R? ( >=dev-lang/R-4.0 )
"
RDEPEND="
	${CDEPEND}
	R? (
		dev-R/BH
		>=dev-R/Rcpp-0.12.12
		dev-R/RcppArmadillo
		dev-R/RcppEnsmallen
		dev-R/roxygen2
		>=dev-R/testthat-2.1.0
	)

	$(python_gen_cond_dep '
		>=dev-libs/boost-1.58[python,${PYTHON_USEDEP}]
		dev-libs/libxml2[${PYTHON_USEDEP}]
		>=dev-python/cython-0.24[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	')

	>=dev-libs/cereal-1.1.2
	dev-libs/stb
	>=sci-libs/armadillo-8.4.0[arpack,blas,lapack]
	>=sci-libs/ensmallen-2.10.0
"
DEPEND="
	${RDEPEND}
	R? ( dev-R/pkgbuild )
	test? ( dev-cpp/catch:0 )
"
BDEPEND="
	app-arch/unzip
	app-text/txt2man
	virtual/pkgconfig

	doc? (
		app-text/doxygen
		dev-libs/mathjax
	)
	test? ( $(python_gen_cond_dep 'dev-python/pytest[${PYTHON_USEDEP}]') )
"

PATCHES=(
	"${FILESDIR}/${PN}-no-pytest-runner.patch"
	"${FILESDIR}/${PN}-link-armadillo.patch"
	"${FILESDIR}/${PN}-3.4.2_p20220501-no-backports.patch"
	"${FILESDIR}/${PN}-3.4.2_p20220501-system-catch.patch"
)
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_unpack() {
	go-module_src_unpack
	use go && go-module_setup_proxy
}

src_prepare() {
	rm src/mlpack/tests/catch.hpp || die
	rm -r src/mlpack/core/std_backport || die
	rm -r src/mlpack/core/cereal/{pair_associative_container,unordered_map}.hpp || die

	sed -i \
		-e "s:share/doc/mlpack:share/doc/${PF}:" \
		-e 's/-O3//g' \
		CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	use R && append-cxxflags "-larmadillo"
	append-cxxflags "-I/usr/include/catch2"

	local mycmakeargs=(
		-DBUILD_CLI_EXECUTABLES=ON
		-DBUILD_PYTHON_BINDINGS=ON
		-DBUILD_SHARED_LIBS=ON
		-DDOWNLOAD_DEPENDENCIES=OFF

		-DARMADILLO_INCLUDE_DIR="${EPREFIX}/usr/include"
		-DARMADILLO_LIBRARY="${EPREFIX}/usr/$(get_libdir)/libarmadillo.so"
		-DCEREAL_INCLUDE_DIR="${EPREFIX}/usr/include"
		-DENSMALLEN_INCLUDE_DIR="${EPREFIX}/usr/include"
		-DSTB_IMAGE_INCLUDE_DIR="${EPREFIX}/usr/include/stb"

		-DARMA_EXTRA_DEBUG=$(usex debug)
		-DBUILD_DOCS=$(usex doc)
		-DBUILD_GO_BINDINGS=OFF
		-DFORCE_BUILD_GO_BINDINGS=$(usex go)
		-DBUILD_GO_SHLIB=$(usex go)
		-DBUILD_JULIA_BINDINGS=$(usex julia)
		-DBUILD_MARKDOWN_BINDINGS=$(usex doc)
		-DBUILD_R_BINDINGS=$(usex R)
		-DBUILD_TESTS=$(usex test)
		-DDEBUG=$(usex debug)
		-DMATHJAX=$(usex doc)
		-DPROFILE=$(usex profile)
		-DTEST_VERBOSE=$(usex test)
		-DUSE_OPENMP=$(usex openmp)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use test && cmake_src_compile mlpack_test
}

src_install() {
	cmake_src_install

	if use R; then
		pushd "${BUILD_DIR}/src/mlpack/bindings/R/" || die
		insinto "/usr/$(get_libdir)/R/site-library"
		rm -r mlpack/src || die
		doins -r mlpack
		popd || die
	fi

	if use source; then
		gosrc="$(go env GOROOT)/src" || die
		insinto "${gosrc}/${EGO_PN}"
		doins -r src/mlpack/bindings/go/mlpack/*
	fi

	python_optimize
}
