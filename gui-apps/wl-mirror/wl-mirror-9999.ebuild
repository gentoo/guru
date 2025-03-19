# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A simple Wayland output mirror client"
HOMEPAGE="https://github.com/Ferdi265/wl-mirror"
EGIT_REPO_URI="https://github.com/Ferdi265/wl-mirror.git"

# as of writing, `main` branch corresponds with release.
# please update as required
EGIT_BRANCH="feature-xdg-portal"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
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
		-DWITH_XDG_PORTAL_BACKEND=ON
	)

	cmake_src_configure
}
