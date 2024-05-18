# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2

DESCRIPTION="Display GTK+ dialog boxes from command line or shell scripts"
HOMEPAGE="https://github.com/v1cont/yad"
SRC_URI="https://github.com/v1cont/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls sourceview spell webkit"

DEPEND="
	>=x11-libs/gtk+-3.22.0:3
	sourceview? ( x11-libs/gtksourceview:3.0= )
	spell? ( app-text/gspell:= )
	webkit? ( net-libs/webkit-gtk:4= )
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-util/intltool-0.40"

src_configure() {
	gnome2_src_configure \
		$(use_enable nls) \
		$(use_enable sourceview) \
		$(use_enable spell) \
		$(use_enable webkit html) \
		--disable-standalone \
		--enable-icon-browser \
		--enable-tools \
		--enable-tray
}
