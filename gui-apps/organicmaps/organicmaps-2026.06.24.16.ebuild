# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_12 python3_13 python3_14 )
inherit python-r1 xdg cmake

JUST_GTFS_COMMIT="7516753825500f90ac2de6f18c256d5abec1ff33"
FAST_OBJ_COMMIT="d620667f10a548dee94dbc8c144bb22f79162176"

IUSE="test"
DESCRIPTION="A privacy-first offline maps & GPS app for hiking, cycling, biking, and driving."
HOMEPAGE="https://organicmaps.app"

SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

MY_PV="${PV%.*}-${PV##*.}-android"
SRC_URI="
	https://github.com/${PN}/${PN}/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/mapsme/just_gtfs/archive/${JUST_GTFS_COMMIT}.tar.gz -> ${P}-just_gtfs-${JUST_GTFS_COMMIT}.tar.gz
	https://github.com/thisistherk/fast_obj/archive/${FAST_OBJ_COMMIT}.tar.gz -> ${P}-fast_obj-${FAST_OBJ_COMMIT}.tar.gz
"

LICENSE="Apache-2.0"
# depend on virtual/zlib:=[minizip] when it is not pulled in as subproject anymore
RDEPEND="
	dev-libs/blake3
	dev-cpp/gflags
	dev-db/sqlite
	dev-lang/python
	dev-libs/boost
	dev-libs/icu
	dev-libs/jansson
	dev-libs/utfcpp
	dev-qt/qtpositioning:6
	dev-qt/qtsvg:6
	dev-util/vulkan-headers
	media-libs/freetype
	>=dev-cpp/glaze-6.5.1
	virtual/zlib:=
	test? ( dev-cpp/gtest )
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}-${MY_PV}"

PATCHES=( "${FILESDIR}"/more-3party-2026.06.24-16.patch )

WORLD_FEED_TESTS_S="${WORKDIR}/world_feed_integration_tests_data-${PV}"

src_prepare() {
	cmake_src_prepare
	rmdir "${S}/3party/just_gtfs" "${S}/3party/fast_obj" 2>/dev/null
	cp -r "${WORKDIR}/just_gtfs-${JUST_GTFS_COMMIT}" "${S}/3party/just_gtfs" || die
	cp -r "${WORKDIR}/fast_obj-${FAST_OBJ_COMMIT}" "${S}/3party/fast_obj" || die
}

src_configure() {
	# organicmaps wants a ./configure.sh execution.
	# However, this setups mainly stuff for Android and XCode builds that we don't need.
	# We need just this line here
	#cp private_default.h private.h || die

	CMAKE_BUILD_TYPE="RelWithDebInfo"
	local mycmakeargs=(
		-DWITH_SYSTEM_PROVIDED_3PARTY=yes
		-DBUILD_SHARED_LIBS=off
		-DTEST_DATA_REPO_URL="${WORLD_FEED_TESTS_S}"
		-DBUILD_TESTING=$(usex test)
		-DPLATFORM_DESKTOP=ON
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update

	einfo "For dark  mode type in search ?dark"
	einfo "For light mode type in search ?light"
}
