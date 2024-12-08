# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=OpenXR-SDK
inherit cmake-multilib

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/KhronosGroup/${MY_PN}.git"
	SLOT="0"
else
	SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_PN}-release-${PV}"
	SLOT="0/${PV}"
fi

DESCRIPTION="OpenXR loader"
HOMEPAGE="https://github.com/KhronosGroup/OpenXR-SDK"

LICENSE="Apache-2.0"

IUSE="+wayland +X"
REQUIRED_USE="|| ( wayland X )"

# dev-libs/jsoncpp-1.9.6: https://bugs.gentoo.org/940262
DEPEND="
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	media-libs/mesa[${MULTILIB_USEDEP}]
	dev-libs/jsoncpp:=[${MULTILIB_USEDEP}]
	!=dev-libs/jsoncpp-1.9.6
	wayland? (
		dev-libs/wayland[${MULTILIB_USEDEP}]
		dev-libs/wayland-protocols
	)
	X? (
		x11-libs/libxcb[${MULTILIB_USEDEP}]
		x11-libs/xcb-util-keysyms
		x11-libs/libXrandr[${MULTILIB_USEDEP}]
		x11-libs/libXxf86vm[${MULTILIB_USEDEP}]
	)
"
RDEPEND="${DEPEND}"
BDEPEND="wayland? ( dev-util/wayland-scanner )"

src_prepare() {
	sed -i 's;DESTINATION share/doc/openxr;DESTINATION ${CMAKE_INSTALL_DOCDIR};' CMakeLists.txt || die

	cmake_src_prepare
}

multilib_src_configure() {
	local mycmakeargs=(
		-DBUILD_WITH_SYSTEM_JSONCPP=ON
		-DBUILD_WITH_XLIB_HEADERS=$(usex X)
		-DBUILD_WITH_XCB_HEADERS=$(usex X)
		-DBUILD_WITH_WAYLAND_HEADERS=$(usex wayland)
		-DPRESENTATION_BACKEND=$(usex X xlib wayland)
	)

	cmake_src_configure
}
