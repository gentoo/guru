# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DOCS_BUILDER="sphinx"
DOCS_DEPEND="dev-python/recommonmark"
DOCS_DIR="docs"
MYPV="${PV/_alpha/a}"
PYTHON_COMPAT=( python3_{7,8,9} )

inherit cmake python-any-r1 docs

DESCRIPTION="header only, dependency-free deep learning framework in C++14"
HOMEPAGE="https://github.com/tiny-dnn/tiny-dnn"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${MYPV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MYPV}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_x86_sse double-precision opencl openmp +serialization tbb test"
REQUIRED_USE="
	?? ( openmp tbb )
"
RESTRICT="test" #tests doesn't build ...

# headers as rdepend because this is also an header only library
RDEPEND="
	opencl? (
		dev-util/opencl-headers
		virtual/opencl
	)
	serialization? ( dev-libs/cereal )
	tbb? ( dev-cpp/tbb )
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/${PN}-add-sphinx-ext-autodoc-to-conf-py.patch"
	"${FILESDIR}/${PN}-disable-gtest-download.patch"
)

src_prepare() {
	#remove bundled cereal
	rm -r cereal || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCS=OFF
		-DBUILD_EXAMPLES=OFF
		-DCOVERALLS=OFF
		-DUSE_LIBDNN=OFF
		-DUSE_NNPACK=OFF

		-DBUILD_TESTS=$(usex test)
		-DUSE_AVX=$(usex cpu_flags_x86_avx)
		-DUSE_AVX2=$(usex cpu_flags_x86_avx2)
		-DUSE_DOUBLE=$(usex double-precision)
		-DUSE_OMP=$(usex openmp)
		-DUSE_OPENCL=$(usex opencl)
		-DUSE_SERIALIZER=$(usex serialization)
		-DUSE_SSE=$(usex cpu_flags_x86_sse)
		-DUSE_TBB=$(usex tbb)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	docs_compile
}

src_install() {
	cmake_src_install
	if use doc; then
		dodoc -r _build/html
		docompress -x "/usr/share/doc/${PF}/html"
	fi
}
