# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit python-any-r1 xdg cmake desktop

DESCRIPTION="Offline maps and navigation using OpenStreetMap data"
HOMEPAGE="https://organicmaps.app"

FAST_OBJ_COMMIT="42629f744269e004907a6fb4f16c6c7f69acc586"
GLAZE_COMMIT="30401f90cee9ef3cde294b62b2b6c2080d0a2810"
GLFW_COMMIT="21fea01161e0d6b70c0c5c1f52dc8e7a7df14a50"
HARFBUZZ_COMMIT="788b469ad5e5f78611f665b6eb17afd0eb040f21"
IMGUI_COMMIT="6982ce43f5b143c5dce5fab0ce07dd4867b705ae"
JUST_GTFS_COMMIT="7516753825500f90ac2de6f18c256d5abec1ff33"
PROTOBUF_COMMIT="9442c12e866b56369f1c53abea1261259c924a19"
TEST_DATA_COMMIT="30ecb0b3fe694a582edfacc2a7425b6f01f9fec6"
WORLD_FEED_TESTS_S="${WORKDIR}/world_feed_integration_tests_data-${TEST_DATA_COMMIT}"

SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/${PV}-5-android.tar.gz -> ${P}.tar.gz
	https://github.com/thisistherk/fast_obj/archive/${FAST_OBJ_COMMIT}.tar.gz -> ${P}-fast_obj-${FAST_OBJ_COMMIT}.tar.gz
	https://github.com/organicmaps/glaze/archive/${GLAZE_COMMIT}.tar.gz -> ${P}-glaze-${GLAZE_COMMIT}.tar.gz
	https://github.com/glfw/glfw/archive/${GLFW_COMMIT}.tar.gz -> ${P}-glfw-${GLFW_COMMIT}.tar.gz
	https://github.com/harfbuzz/harfbuzz/archive/${HARFBUZZ_COMMIT}.tar.gz -> ${P}-harfbuzz-${HARFBUZZ_COMMIT}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_COMMIT}.tar.gz -> ${P}-imgui-${IMGUI_COMMIT}.tar.gz
	https://github.com/organicmaps/just_gtfs/archive/${JUST_GTFS_COMMIT}.tar.gz -> ${P}-just_gtfs-${JUST_GTFS_COMMIT}.tar.gz
	https://github.com/organicmaps/protobuf/archive/${PROTOBUF_COMMIT}.tar.gz -> ${P}-protobuf-${PROTOBUF_COMMIT}.tar.gz
	test? ( https://github.com/${PN}/world_feed_integration_tests_data/archive/${TEST_DATA_COMMIT}.tar.gz -> ${P}-test_data-${TEST_DATA_COMMIT}.tar.gz )
"

S="${WORKDIR}/${P}-5-android"
LICENSE="Apache-2.0 BSD MIT ZLIB Old-MIT ISC icu"

SLOT="0"

KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-util/vulkan-headers
	${PYTHON_DEPS}
	test? ( dev-cpp/gtest )
"

# depend on sys-libs/zlib[minizip] when it is not pulled in as subproject anymore
RDEPEND="
	dev-cpp/gflags:=
	dev-db/sqlite:=
	dev-libs/boost:=
	dev-libs/icu:=
	dev-libs/jansson:=
	dev-libs/pugixml
	dev-libs/utfcpp
	dev-qt/qtbase:=[gui,network,opengl,widgets]
	dev-qt/qtpositioning:=
	dev-qt/qtsvg:=
	media-libs/freetype:=
	virtual/zlib:=
"

DEPEND="
	${RDEPEND}
	dev-cpp/fast_float
	media-libs/glm
"

PATCHES=(
	"${FILESDIR}"/fix-system-boost-target.patch
	"${FILESDIR}"/fix-jansson.patch
	"${FILESDIR}"/protobuf.patch
	"${FILESDIR}"/respect-ldflags.patch
	"${FILESDIR}"/drape.patch
	"${FILESDIR}"/gtest.patch
	"${FILESDIR}"/timezone-put-time.patch
)

src_unpack() {
	default

	rm -rf \
		"${S}/3party/fast_obj" \
		"${S}/3party/glaze" \
		"${S}/3party/glfw" \
		"${S}/3party/harfbuzz/harfbuzz" \
		"${S}/3party/imgui/imgui" \
		"${S}/3party/just_gtfs" \
		"${S}/3party/protobuf/protobuf" || die

	mv "${WORKDIR}/fast_obj-${FAST_OBJ_COMMIT}" "${S}/3party/fast_obj" || die
	mv "${WORKDIR}/glaze-${GLAZE_COMMIT}" "${S}/3party/glaze" || die
	mv "${WORKDIR}/glfw-${GLFW_COMMIT}" "${S}/3party/glfw" || die
	mv "${WORKDIR}/harfbuzz-${HARFBUZZ_COMMIT}" "${S}/3party/harfbuzz/harfbuzz" || die
	mv "${WORKDIR}/imgui-${IMGUI_COMMIT}" "${S}/3party/imgui/imgui" || die
	mv "${WORKDIR}/just_gtfs-${JUST_GTFS_COMMIT}" "${S}/3party/just_gtfs" || die
	mv "${WORKDIR}/protobuf-${PROTOBUF_COMMIT}" "${S}/3party/protobuf/protobuf" || die

	if use test; then
		mkdir -p "${S}/data/test_data" || die
		rm -rf "${S}/data/test_data/world_feed_integration_tests_data" || die
		cp -a "${WORLD_FEED_TESTS_S}" "${S}/data/test_data/world_feed_integration_tests_data" || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DWITH_SYSTEM_PROVIDED_3PARTY=yes
		-DBUILD_SHARED_LIBS=off
		-DUSE_CCACHE=off
		-DTEST_DATA_REPO_URL="$(usex test "${WORLD_FEED_TESTS_S}" "")"
		-DSKIP_TESTS="$(usex !test)"
	)
	cmake_src_configure
}

src_compile() {
	if use test; then
		cmake_src_compile
	else
		cmake_src_compile desktop
	fi
}

src_test() {
	cmake_src_test
}

src_install() {
	dobin "${BUILD_DIR}"/OMaps

	insinto /usr/share/organicmaps
	doins -r data

	insinto /usr/share/metainfo
	doins packaging/app.organicmaps.desktop.metainfo.xml
	domenu qt/res/linux/app.organicmaps.desktop.desktop
	newicon -s 512 qt/res/logo.png organicmaps.png

	rm -rf "${ED}"/usr/share/${PN}/data/world_feed_integration_tests_data || die
}

pkg_postinst() {
	xdg_pkg_postinst

	einfo "For dark  mode type in search ?dark"
	einfo "For light mode type in search ?light"
}
