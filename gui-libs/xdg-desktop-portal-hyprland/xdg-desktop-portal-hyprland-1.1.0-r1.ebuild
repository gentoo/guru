# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson toolchain-funcs

DESCRIPTION="xdg-desktop-portal backend for hyprland"
HOMEPAGE="https://github.com/hyprwm/xdg-desktop-portal-hyprland"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland.git"
	inherit git-r3
else
	SRC_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland/archive/refs/tags/v${PV}.tar.gz \
		-> xdg-desktop-hyprland-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0/9999"
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

src_prepare() {
		eapply "${FILESDIR}/xdg-desktop-portal-hyprland-1.1.0_fix_clang.patch"
		default
}

src_compile() {
	meson_src_compile
	emake -C hyprland-share-picker all
}

src_install() {
	meson_src_install
	dobin "${S}/hyprland-share-picker/build/hyprland-share-picker"
}
