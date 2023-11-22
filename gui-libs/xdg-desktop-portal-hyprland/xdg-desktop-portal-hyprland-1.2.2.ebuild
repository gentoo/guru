# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="xdg-desktop-portal backend for hyprland"
HOMEPAGE="https://github.com/hyprwm/xdg-desktop-portal-hyprland"

KEYWORDS="~amd64"
PROTO_COMMIT="4d29e48433270a2af06b8bc711ca1fe5109746cd"
SRC_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland/archive/refs/tags/v${PV}.tar.gz \
	-> xdg-desktop-hyprland-${PV}.tar.gz
https://github.com/hyprwm/hyprland-protocols/archive/${PROTO_COMMIT}.tar.gz \
	-> proto-subproject-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	>=media-video/pipewire-0.3.41:=
	dev-cpp/sdbus-c++
	dev-libs/inih
	dev-libs/wayland
	dev-qt/qtbase
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwayland:6
	dev-qt/qtwidgets
	media-libs/mesa
	sys-apps/util-linux
	x11-libs/libdrm
	|| (
		systemd? ( >=sys-apps/systemd-237 )
		elogind? ( >=sys-auth/elogind-237 )
		sys-libs/basu
	)
"

RDEPEND="
	${DEPEND}
	sys-apps/xdg-desktop-portal
"

BDEPEND="
	>=dev-libs/wayland-protocols-1.24
	dev-libs/hyprland-protocols
	virtual/pkgconfig
	|| ( >=sys-devel/gcc-13:* >=sys-devel/clang-17:* )
"

pkg_setup() {
	[[ ${MERGE_TYPE} == binary ]] && return

	if tc-is-gcc && ver_test $(gcc-version) -lt 13 ; then
		eerror "XDPH needs >=gcc-13 or >=clang-17 to compile."
		eerror "Please upgrade GCC: emerge -v1 sys-devel/gcc"
		die "GCC version is too old to compile XDPH!"
	elif tc-is-clang && ver_test $(clang-version) -lt 17 ; then
		eerror "XDPH needs >=gcc-13 or >=clang-17 to compile."
		eerror "Please upgrade Clang: emerge -v1 sys-devel/clang"
		die "Clang version is too old to compile XDPH!"
	fi
}

src_unpack() {
	default
	rmdir "${S}/subprojects/hyprland-protocols" || die
	mv "hyprland-protocols-${PROTO_COMMIT}" "${S}/subprojects/hyprland-protocols" || die
}

src_prepare() {
	default
	eapply "${FILESDIR}/xdg-desktop-portal-hyprland-1.2.5_use_sys_sdbus-c++.patch"
	cmake_src_prepare
}

src_compile() {
	cmake_src_compile all
}

src_install() {
	cmake_src_install
	exeinto /usr/libexec
	doexe "${BUILD_DIR}/xdg-desktop-portal-hyprland"
}
