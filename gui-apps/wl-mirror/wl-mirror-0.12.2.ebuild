# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A simple Wayland output mirror client"
HOMEPAGE="https://github.com/Ferdi265/wl-mirror"
SRC_URI="https://github.com/Ferdi265/wl-mirror/releases/download/v${PV}/wl-mirror-${PV}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="man"

DEPEND="
	gui-libs/wlroots
	dev-libs/wayland-protocols
	dev-libs/wayland
	media-libs/libglvnd
	dev-util/wayland-scanner
	man? (
		app-text/scdoc
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DINSTALL_DOCUMENTATION=$(usex man ON OFF)
		-DFORCE_SYSTEM_WL_PROTOCOLS=ON
		-DFORCE_SYSTEM_WLR_PROTOCOLS=OFF
		-DINSTALL_EXAMPLE_SCRIPTS=OFF
	)

	cmake_src_configure
}
