# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="xdg-desktop-portal backend for hyprland"
HOMEPAGE="https://github.com/hyprwm/xdg-desktop-portal-hyprland"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland.git"
	inherit git-r3
else
	SRC_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland/archive/refs/tags/v${PV}.tar.gz -> xdg-desktop-hyprland-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0/9999"
IUSE="elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	>=media-video/pipewire-0.3.41:=
	dev-libs/inih
	dev-libs/wayland
	dev-qt/qtbase
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwayland:6
	dev-qt/qtwidgets
	media-libs/mesa
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
	virtual/pkgconfig
"

src_configure() {
	local emasonargs=()
	if use systemd; then
		emasonargs+=(-Dsd-bus-provider=libsystemd)
	elif use elogind; then
		emasonargs+=(-Dsd-bus-provider=libelogind)
	else
		emasonargs+=(-Dsd-bus-provider=basu)
	fi
	meson_src_configure
}

src_compile() {
	cd hyprland-share-picker || die
	make all || die "Couldn't compile hyprland-share-picker"
	cd .. || die
	meson_src_compile
}

src_install() {
	meson_src_install
	dobin "${WORKDIR}"/xdg-desktop-portal-hyprland-${PV}/hyprland-share-picker/build/hyprland-share-picker
}
