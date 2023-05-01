# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_DEPEND="dev-python/recommonmark"
DOCS_DIR="docs"
MYPV="${PV/_alpha/a}"
PYTHON_COMPAT=( python3_{10..11} )

inherit cmake python-any-r1 docs

DESCRIPTION="header only, dependency-free deep learning framework in C++14"
HOMEPAGE="https://github.com/tiny-dnn/tiny-dnn"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${MYPV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MYPV}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_x86_sse double-precision opencl openmp +serialization tbb test" # TODO: cuda

# headers as rdepend because this is also an header only library
RDEPEND="
	dev-cpp/gemmlowp
	dev-libs/stb
	opencl? (
		dev-util/opencl-headers
		virtual/opencl
	)
	serialization? ( dev-libs/cereal )
	tbb? ( dev-cpp/tbb )
"
DEPEND="
	${RDEPEND}
	test? (
		dev-cpp/catch:0
		dev-cpp/gtest
	)
"

REQUIRED_USE="^^ ( openmp tbb )"
RESTRICT="test" #tests doesn't build ...
PATCHES=(
	"${FILESDIR}/${PN}-add-sphinx-ext-autodoc-to-conf-py.patch"
	"${FILESDIR}/${PN}-disable-gtest-download.patch"
	"${FILESDIR}/${P}-system-libs.patch"
)

src_prepare() {
	#remove bundled cereal
	rm -r cereal || die
	rm -r third_party || die
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
