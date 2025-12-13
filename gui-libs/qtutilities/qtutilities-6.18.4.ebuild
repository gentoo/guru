# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake multibuild virtualx

DESCRIPTION="Useful Qt related C++ classes and routines"
HOMEPAGE="https://github.com/Martchus/qtutilities"

SRC_URI="https://github.com/Martchus/qtutilities/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/$(ver_cut 1)"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/cpp-utilities
	dev-qt/qtbase:6[dbus,gui,widgets]
	dev-qt/qttools:6[linguist]
"
DEPEND="${RDEPEND}"

pkg_setup() {
	MULTIBUILD_VARIANTS=( qt6 )
}

multibuild_src_configure() {
	local mycmakeargs=(
		-DCONFIGURATION_NAME="${MULTIBUILD_VARIANT}"
		-DCONFIGURATION_TARGET_SUFFIX="${MULTIBUILD_VARIANT}"
		-DEXCLUDE_TESTS_FROM_ALL=$(usex !test)
	)
	case "${MULTIBUILD_VARIANT}" in
		qt6) mycmakeargs+=( -DQT_PACKAGE_PREFIX=Qt6 ) ;;
	esac
	cmake_src_configure
}

src_configure() {
	multibuild_foreach_variant multibuild_src_configure
}

src_compile() {
	multibuild_foreach_variant cmake_src_compile
}

src_test() {
	virtx multibuild_foreach_variant cmake_src_test
}

src_install() {
	multibuild_foreach_variant cmake_src_install
}
