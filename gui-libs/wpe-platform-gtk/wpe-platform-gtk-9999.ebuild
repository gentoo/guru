# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A GTK implementation for WPE platform"
HOMEPAGE="https://github.com/Igalia/wpe-platform-gtk"

LICENSE="LGPL-2.1+"
SLOT="1.0"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Igalia/wpe-platform-gtk.git"
else
	KEYWORDS="~amd64"
fi

IUSE="wayland X"
REQUIRED_USE="
	|| ( wayland X )
"

DEPEND="
	>=net-libs/wpewebkit-2.54.0:2.0[wayland?]
	dev-libs/glib:2
	gui-libs/gtk:4[wayland?,X?]
	media-libs/libepoxy
	x11-libs/cairo[X?]
"

RDEPEND="
	${DEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	use wayland || append-flags -DGENTOO_GTK_HIDE_WAYLAND
	use X || append-flags -DGENTOO_GTK_HIDE_X11

	meson_src_configure
}
