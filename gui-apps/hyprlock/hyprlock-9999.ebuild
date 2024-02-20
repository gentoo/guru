# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

COMMIT="7b15d34f0af9b1c8ef49279827eee47e4dca9afa"
DESCRIPTION="Hyprland's GPU-accelerated screen locking utility"
HOMEPAGE="https://github.com/hyprwm/hyprlock"

if [[ "${PV}" = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hyprwm/${PN^}.git"
else
	#When releases start to happen
	#SRC_URI="https://github.com/hyprwm/${PN^}/releases/download/v${PV}/source-v${PV}.tar.gz -> ${P}.gh.tar.gz"
	#S="${WORKDIR}/${PN}-source"

	SRC_URI="https://github.com/hyprwm/${PN^}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"

	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-libs/wayland
	gui-libs/egl-wayland
	media-libs/mesa[egl(+),gles2]
	sys-libs/pam
	>=gui-wm/hyprland-0.35.0
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"

BDEPEND="
	>=dev-libs/hyprlang-0.4.0
	x11-libs/libxkbcommon
	x11-libs/cairo
	dev-build/cmake
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE:STRING=Release
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
}
