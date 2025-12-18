# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg-utils

DESCRIPTION="Small text editor by the Linux Mint developers"
HOMEPAGE="https://github.com/linuxmint/xed"
SRC_URI="https://github.com/linuxmint/xed/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk-doc spell"

RDEPEND="
	>=dev-libs/libxml2-2.5.0:=
	>=dev-libs/glib-2.40.0
	>=x11-libs/gtk+-3.19.3:=
	>=x11-libs/gtksourceview-4.0.3
	>=dev-libs/libpeas-1.12.0
	<dev-libs/libpeas-2.0.0
	x11-libs/pango
	x11-libs/libxklavier
	>=x11-libs/xapp-1.9.0
	spell? ( >=app-text/gspell-0.2.5 )
	gtk-doc? ( dev-util/gtk-doc )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-util/itstool
"

src_configure() {
	local emesonargs=(
		$(meson_use spell enable_spell)
		$(meson_use gtk-doc docs)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
