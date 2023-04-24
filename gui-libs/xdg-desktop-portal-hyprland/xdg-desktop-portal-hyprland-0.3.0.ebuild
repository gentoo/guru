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
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland/archive/refs/tags/v${PV}.tar.gz \
		-> xdg-desktop-hyprland-${PV}.tar.gz"
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
"

src_configure() {
	local emesonargs=()
	if use systemd; then
		emesonargs+=(-Dsd-bus-provider=libsystemd)
	elif use elogind; then
		emesonargs+=(-Dsd-bus-provider=libelogind)
	else
		emesonargs+=(-Dsd-bus-provider=basu)
	fi
	meson_src_configure
}

src_compile() {
	meson_src_compile
	emake -C hyprland-share-picker all
}

src_install() {
	meson_src_install
	dobin "${S}/hyprland-share-picker/build/hyprland-share-picker"
}
