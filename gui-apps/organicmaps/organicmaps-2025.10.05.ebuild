# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
inherit python-any-r1 xdg cmake desktop

DESCRIPTION="Offline maps and navigation using OpenStreetMap data"
HOMEPAGE="https://organicmaps.app"

SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/${PV}-7-android.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/${PN}/world_feed_integration_tests_data/archive/30ecb0b3fe694a582edfacc2a7425b6f01f9fec6.tar.gz -> test_data.tar.gz )"

S="${WORKDIR}/${P}-7-android"
LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-util/vulkan-headers
	dev-cpp/fast_double_parser
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
	sys-libs/zlib:=
"

DEPEND="media-libs/glm"

PATCHES=( "${FILESDIR}"/fix-jansson.patch "${FILESDIR}"/protobuf.patch "${FILESDIR}"/respect-ldflags.patch )

src_configure() {
	local mycmakeargs=(
		-DWITH_SYSTEM_PROVIDED_3PARTY=yes
		-DBUILD_SHARED_LIBS=off
		-DSKIP_TESTS="$(usex !test)"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile desktop
	use test && cmake_src_compile
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
