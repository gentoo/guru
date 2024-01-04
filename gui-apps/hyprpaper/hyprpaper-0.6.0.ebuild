# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A blazing fast wayland wallpaper utility"
HOMEPAGE="https://github.com/hyprwm/hyprpaper"
SRC_URI="https://github.com/hyprwm/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/cmake
	dev-util/wayland-scanner
	dev-vcs/git
"
RDEPEND="
	dev-libs/hyprlang
	gui-libs/wlroots
	media-libs/libglvnd
	media-libs/libjpeg-turbo
	media-libs/libwebp
	x11-libs/cairo
	x11-libs/pango
"

src_compile() {
	emake protocols
	cmake_src_compile
}

src_install() {
	dobin "${BUILD_DIR}/${PN}"
}
