# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
inherit cmake edo python-any-r1

DESCRIPTION="Header only C++11 tiny glTF 2.0 library"
HOMEPAGE="https://github.com/syoyo/tinygltf"

SAMPLE_MODELS="d7a3cc8e51d7c573771ae77a57f16b0662a905c6"
SRC_URI="
	https://github.com/syoyo/tinygltf/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	test? (
		https://github.com/KhronosGroup/glTF-Sample-Models/archive/${SAMPLE_MODELS}.tar.gz
			-> glTF-Sample-Models-${SAMPLE_MODELS}.tar.gz
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples test"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}/0001-Use-nlohmann-and-stb-packages-instead-of-bundled-one.patch"
)

RDEPEND="
	dev-libs/stb
	dev-cpp/nlohmann_json
	examples? (
		media-libs/glew:=
		media-libs/glfw
		media-libs/glu
		virtual/opengl
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	test? (
		${PYTHON_DEPS}
	)
"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare

	if use test; then
		mv -T "${WORKDIR}/glTF-Sample-Models-${SAMPLE_MODELS}" "${WORKDIR}/glTF-Sample-Models" || die
	fi

	sed -i -e 's/clang++/$(CXX)/' tests/Makefile || die
	sed -i \
		-e "s|^sample_model_dir = \".*\"|sample_model_dir = \"${WORKDIR}/glTF-Sample-Models\"|" \
		-e "s|\"./loader_example\"|\"${BUILD_DIR}/loader_example\"|" \
		test_runner.py || die
}

src_configure() {
	local mycmakeargs=(
		-DTINYGLTF_BUILD_LOADER_EXAMPLE=$(usex test)
		-DTINYGLTF_BUILD_GL_EXAMPLES=$(usex examples)
		-DTINYGLTF_BUILD_VALIDATOR_EXAMPLE=$(usex examples)
		-DTINYGLTF_BUILD_BUILDER_EXAMPLE=$(usex examples)
		-DTINYGLTF_HEADER_ONLY=OFF
		-DTINYGLTF_INSTALL=ON
		-DTINYGLTF_INSTALL_VENDOR=OFF
	)
	#use examples && mycmakeargs+=( -DOpenGL_GL_PREFERENCE=GLVND )
	cmake_src_configure
}

src_test() {
	# unit tests
	pushd tests >/dev/null || die
	emake
	edo ./tester
	edo ./tester_noexcept
	popd >/dev/null || die

	# glTF parsing tests
	edo "${EPYTHON}" test_runner.py
}
