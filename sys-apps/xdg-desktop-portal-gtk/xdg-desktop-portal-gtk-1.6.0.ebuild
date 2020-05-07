# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

SRC_URI="https://github.com/flatpak/${PN}/releases/download/${PV}/${P}.tar.xz"
DESCRIPTION="GTK/GNOME backend for xdg-desktop-portal"
HOMEPAGE="https://github.com/flatpak/xdg-desktop-portal-gtk"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland X"

RDEPEND="
	gnome-base/gnome-desktop:3
	media-libs/fontconfig
	>=dev-libs/glib-2.44:2[dbus]
	>=x11-libs/gtk+-3.21.5:3[wayland=,X=]
	>=sys-apps/xdg-desktop-portal-1.6.0-r1
"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.18.3
"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local myeconfargs=(
		--with-systemduserunitdir="$(systemd_get_userunitdir)"
	)
	econf "${myeconfargs[@]}"
}
