# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

COMMIT="57e80006602b7857fb23feded368055df62b8cb3"
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
	media-libs/mesa[opengl]
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
	x11-libs/libdrm
	x11-libs/cairo
	x11-libs/pango
	dev-build/cmake
	dev-libs/date
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/0001-fix-CFLAGS-CXXFLAGS-hyprlock.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE:STRING=Release
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
}
