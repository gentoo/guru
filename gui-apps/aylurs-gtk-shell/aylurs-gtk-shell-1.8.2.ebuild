# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="v${PV}"
MY_PN="ags"

inherit meson

DESCRIPTION="Aylurs's Gtk Shell (AGS), An eww inspired gtk widget system."
HOMEPAGE="https://github.com/Aylur/ags"
SRC_URI="
	https://github.com/Aylur/${MY_PN}/releases/download/${MY_PV}/${MY_PN}-${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Aylur/${MY_PN}/releases/download/${MY_PV}/node_modules-${MY_PV}.tar.gz -> node-modules.tar.gz
"
S="${WORKDIR}/${MY_PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="upower bluetooth networkmanager tray"

BDEPEND="
	dev-lang/typescript
	net-libs/nodejs[npm]
"
RDEPEND="
	dev-libs/gjs
	x11-libs/gtk+
	gui-libs/gtk-layer-shell[introspection]
	dev-libs/gobject-introspection
	upower? ( sys-power/upower )
	bluetooth? ( net-wireless/gnome-bluetooth )
	networkmanager? ( net-misc/networkmanager )
	tray? ( dev-libs/libdbusmenu[gtk3] )
"

DEPEND="
	${RDEPEND}
"

BUILD_DIR="${S}/build"

src_prepare() {
	default
	mv "${WORKDIR}/node_modules" "${S}"
}

src_configure() {
	local emesonargs=(
		-Dbuild_types="true"
	)
	meson_src_configure
}

pkg_postinst() {
	elog "ags wont run without a config file (usually in ~/.config/ags)."
	elog "For example configs visit https://aylur.github.io/ags-docs/"
}
