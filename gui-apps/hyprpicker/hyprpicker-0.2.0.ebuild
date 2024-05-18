# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A wlroots-compatible Wayland color picker that does not suck"
HOMEPAGE="https://github.com/hyprwm/hyprpicker"
SRC_URI="https://github.com/hyprwm/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	media-libs/libglvnd
	media-libs/libjpeg-turbo
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libxkbcommon
"

src_compile() {
	emake protocols
	cmake_src_compile
}

src_install() {
	dobin "${BUILD_DIR}/${PN}"
}
