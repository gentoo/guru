# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="xdg-desktop-portal backend for Hyprland"
HOMEPAGE="https://github.com/hyprwm/xdg-desktop-portal-hyprland"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hyprwm/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	>=dev-cpp/sdbus-c++-2.0.0
	dev-libs/hyprlang:=
	dev-libs/inih
	dev-libs/wayland
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtwayland:6
	gui-libs/hyprutils:=
	media-libs/mesa
	>=media-video/pipewire-1.2.0:=
	x11-libs/libdrm
	|| (
		sys-libs/basu
		elogind? ( >=sys-auth/elogind-237 )
		systemd? ( >=sys-apps/systemd-237 )
	)
"

RDEPEND="
	${DEPEND}
	sys-apps/xdg-desktop-portal
"

BDEPEND="
	dev-libs/hyprland-protocols
	>=dev-libs/wayland-protocols-1.24
	>=dev-util/hyprwayland-scanner-0.4.2
	virtual/pkgconfig
	|| ( >=sys-devel/gcc-14:* >=llvm-core/clang-17:* )
"

pkg_setup() {
	[[ ${MERGE_TYPE} == binary ]] && return

	if tc-is-gcc && ver_test $(gcc-version) -lt 14 ; then
		eerror "XDPH needs >=gcc-14 or >=clang-17 to compile."
		eerror "Please upgrade GCC: emerge -v1 sys-devel/gcc"
		die "GCC version is too old to compile XDPH!"
	elif tc-is-clang && ver_test $(clang-version) -lt 17 ; then
		eerror "XDPH needs >=gcc-14 or >=clang-17 to compile."
		eerror "Please upgrade Clang: emerge -v1 llvm-core/clang"
		die "Clang version is too old to compile XDPH!"
	fi
}

src_prepare() {
	sed -i "/add_compile_options(-O3)/d" "${S}/CMakeLists.txt" || die
	cmake_src_prepare
}
