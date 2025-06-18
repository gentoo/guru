# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm linux-info optfeature toolchain-funcs xdg-utils

DESCRIPTION="Core control application"
HOMEPAGE="https://gitlab.com/corectrl/corectrl"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/corectrl/corectrl.git"
else
	SRC_URI="https://gitlab.com/corectrl/corectrl/-/archive/v${PV}/corectrl-v${PV}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	dev-libs/botan:=
	dev-libs/pugixml
	dev-libs/spdlog:=
	>=dev-libs/quazip-1.3:=[qt6]
	dev-qt/qtbase:6[dbus,gui,network,widgets]
	dev-qt/qtcharts:6[qml]
	dev-qt/qtdeclarative:6
	sys-auth/polkit[introspection]
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/units
	dev-qt/qttools:6[linguist]
	dev-qt/qtsvg:6
	x11-libs/libdrm[video_cards_amdgpu]
	test? (
		>=dev-cpp/catch-3.5.2
		dev-cpp/trompeloeil
	)
"

RDEPEND="${COMMON_DEPEND}
	dev-libs/glib
	dev-libs/libfmt:=
	dev-qt/qtquickcontrols2
"
CONFIG_CHECK="~CONNECTOR ~PROC_EVENTS ~NETLINK_DIAG"

src_prepare() {
	if [[ $(tc-get-cxx-stdlib) == "libc++" ]]; then
		sed -i 's/stdc++fs//g' src/CMakeLists.txt src/helper/CMakeLists.txt || die
	fi
	cmake_src_prepare
}

pkg_setup() {
	linux-info_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	optfeature "vulkaninfo" dev-util/vulkan-tools
	optfeature "glxinfo" x11-apps/mesa-progs
}

pkg_postrm() {
	xdg_icon_cache_update
}
