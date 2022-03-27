# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit cmake python-single-r1

DESCRIPTION="Dynamic Animation and Robotics Toolkit"
HOMEPAGE="
	https://dartsim.github.io
	https://github.com/dartsim/dart
"
SRC_URI="https://github.com/dartsim/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bullet doc examples extras glut gui +ipopt +nlopt ode python test tests tutorials urdfdom
cpu_flags_x86_mmx cpu_flags_x86_mmxext	cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3
cpu_flags_x86_ssse3 cpu_flags_x86_sse4a cpu_flags_x86_sse4_1 cpu_flags_x86_sse4_2 cpu_flags_x86_avx
cpu_flags_x86_avx2 cpu_flags_x86_avx512dq cpu_flags_x86_avx512f cpu_flags_x86_avx512vl
cpu_flags_x86_3dnow cpu_flags_x86_3dnowext cpu_flags_ppc_vsx cpu_flags_ppc_vsx2 cpu_flags_ppc_vsx3
cpu_flags_ppc_altivec cpu_flags_arm_neon cpu_flags_arm_iwmmxt cpu_flags_arm_iwmmxt2 cpu_flags_arm_neon"
#TODO: pagmo

RDEPEND="
	app-arch/lz4
	>=dev-cpp/eigen-3.0.5
	dev-libs/boost
	dev-libs/tinyxml2
	>=sci-libs/libccd-2.0
	>=media-libs/assimp-3.0.0
	>=sci-libs/fcl-0.2.9
	sci-libs/flann
	sci-libs/octomap

	bullet? ( sci-physics/bullet )
	examples? (
		dev-cpp/tiny-dnn
		dev-libs/urdfdom
	)
	extras? ( dev-libs/urdfdom )
	glut? ( media-libs/freeglut )
	gui? (
		dev-games/openscenegraph
		media-libs/imgui:=[opengl(-)]
		media-libs/lodepng:=
		virtual/opengl
		x11-libs/libXi
		x11-libs/libXmu
	)
	ipopt? ( sci-libs/ipopt )
	nlopt? ( >=sci-libs/nlopt-2.4.1 )
	ode? ( dev-games/ode )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep 'dev-python/pybind11[${PYTHON_USEDEP}]')
	)
	urdfdom? ( dev-libs/urdfdom )
"
DEPEND="
	${RDEPEND}
	examples? ( dev-libs/urdfdom_headers )
	extras? ( dev-libs/urdfdom_headers )
	test? (
		dev-cpp/gtest
		python? ( $(python_gen_cond_dep 'dev-python/pytest[${PYTHON_USEDEP}]') )
	)
	urdfdom? ( dev-libs/urdfdom_headers )
"
BDEPEND="
	app-text/dos2unix
	doc? ( app-doc/doxygen )
	test? ( python? ( $(python_gen_cond_dep 'dev-python/pytest[${PYTHON_USEDEP}]') ) )
"

RESTRICT="!test? ( test )"
PATCHES=(
	"${FILESDIR}/${PN}-respect-ldflags.patch"
	"${FILESDIR}/${P}-respect-cflags.patch"
	"${FILESDIR}/${P}-use-system-gtest.patch"
	"${FILESDIR}/${P}-use-system-lodepng-imgui.patch"
)
REQUIRED_USE="
	examples? ( gui )
	python? (
		${PYTHON_REQUIRED_USE}
		gui
	)

	|| ( ipopt nlopt )
"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	# delete bundled gtest
	rm -r unittests/gtest || die
	rm -r dart/external/{imgui,lodepng} || die
	dos2unix unittests/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local simd=OFF
	use cpu_flags_x86_mmx && simd=ON
	use cpu_flags_x86_mmxext && simd=ON
	use cpu_flags_x86_sse && simd=ON
	use cpu_flags_x86_sse2 && simd=ON
	use cpu_flags_x86_sse3 && simd=ON
	use cpu_flags_x86_ssse3 && simd=ON
	use cpu_flags_x86_sse4a && simd=ON
	use cpu_flags_x86_sse4_1 && simd=ON
	use cpu_flags_x86_sse4_2 && simd=ON
	use cpu_flags_x86_avx && simd=ON
	use cpu_flags_x86_avx2 && simd=ON
	use cpu_flags_x86_avx512dq && simd=ON
	use cpu_flags_x86_avx512f && simd=ON
	use cpu_flags_x86_avx512vl && simd=ON
	use cpu_flags_x86_3dnow && simd=ON
	use cpu_flags_x86_3dnowext && simd=ON
	use cpu_flags_ppc_vsx && simd=ON
	use cpu_flags_ppc_vsx2 && simd=ON
	use cpu_flags_ppc_vsx3 && simd=ON
	use cpu_flags_ppc_altivec && simd=ON
	use cpu_flags_arm_neon && simd=ON
	use cpu_flags_arm_iwmmxt && simd=ON
	use cpu_flags_arm_iwmmxt2 && simd=ON
	use cpu_flags_arm_neon && simd=ON

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
		-DDART_CODECOV=OFF
		-DDART_VERBOSE=ON
		-DDART_TREAT_WARNINGS_AS_ERRORS=OFF

		-DDART_BUILD_EXTRAS=$(usex extras)
		-DDART_BUILD_GUI_OSG=$(usex gui)
		-DDART_ENABLE_SIMD="${simd}"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use examples && cmake_build examples
	use python && cmake_build dartpy # no work to do ...
	use test && cmake_build tests
	use tutorials && cmake_build tutorials
}

src_install() {
	cmake_src_install
	#TODO: python examples tests tutorials
	mv "${ED}/usr/share/doc/dart" "${ED}/usr/share/doc/${PF}" || die
	docompress -x "/usr/share/doc/${PF}"
}
