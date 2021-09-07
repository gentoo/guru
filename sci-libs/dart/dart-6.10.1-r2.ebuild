# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit cmake python-single-r1

DESCRIPTION="Dynamic Animation and Robotics Toolkit"
HOMEPAGE="https://dartsim.github.io"
SRC_URI="https://github.com/dartsim/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bullet doc examples extras glut +ipopt +nlopt ode openscenegraph python test tests tutorials urdfdom"
#TODO: pagmo
#TODO: unbundle imgui
RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}/${PN}-respect-ldflags.patch" )
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )

	|| ( ipopt nlopt )
"

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
	virtual/opengl
	x11-libs/libXi
	x11-libs/libXmu

	bullet? ( sci-physics/bullet )
	examples? ( dev-games/openscenegraph )
	glut? ( media-libs/freeglut )
	ipopt? ( sci-libs/ipopt )
	nlopt? ( >=sci-libs/nlopt-2.4.1 )
	ode? ( dev-games/ode )
	openscenegraph? ( dev-games/openscenegraph )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-python/pybind11[${PYTHON_USEDEP}]
		')
	)
	urdfdom? ( dev-libs/urdfdom )
"
DEPEND="
	${RDEPEND}
	urdfdom? ( dev-libs/urdfdom_headers )
"
BDEPEND="doc? ( app-doc/doxygen )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DDART_VERBOSE=ON

		-DDART_BUILD_DARTPY=$(usex python)
		-DDART_BUILD_EXTRAS=$(usex extras)
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
