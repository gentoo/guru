# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson optfeature

DESCRIPTION="Aylurs's Gtk Shell (AGS), An eww inspired gtk widget system."
HOMEPAGE="https://github.com/Aylur/ags"
SRC_URI="
	https://github.com/Aylur/ags/releases/download/v${PV}/ags-v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Aylur/ags/releases/download/v${PV}/node_modules-v${PV}.tar.gz -> ${P}-node-modules.tar.gz
"
S="${WORKDIR}/ags"
BUILD_DIR="${S}/build"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# grep -rEo "gi://.*'" | cut -d : -f 1 --complement | sort -u
COMMON_DEPEND="
	>=dev-libs/gjs-1.73.1
	>=dev-libs/glib-2.56.0:2
	>=dev-libs/gobject-introspection-1.49.1
	>=media-libs/libpulse-12.99.3[glib]
	x11-libs/gtk+:3[introspection]
	sys-libs/pam
"
RDEPEND="
	${COMMON_DEPEND}
	gui-libs/gtk-layer-shell[introspection]
	x11-libs/gdk-pixbuf[introspection]
	x11-libs/pango[introspection]
	=x11-libs/cairo-1*[glib]
"
# gjs-1.0.pc pulls in xorg-proto via cairo-xlib dep
DEPEND="
	${COMMON_DEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	dev-lang/typescript
	dev-libs/gobject-introspection
	dev-util/glib-utils
"

PATCHES=(
	"${FILESDIR}/${P}-correct_bin_src.patch"
)

src_prepare() {
	default
	mv "${WORKDIR}/node_modules" "${S}" || die
}

src_configure() {
	local emesonargs=(
		-Dbuild_types="true"
	)
	meson_src_configure
}

src_install() {
	local DOCS="CHANGELOG.md README.md example"
	meson_src_install
}

pkg_postinst() {
	elog "ags wont run without a config file (usually in ~/.config/ags)."
	elog "For example configs visit https://aylur.github.io/ags-docs/"
	optfeature "battery service" sys-power/upower
	optfeature "bluetooth service" net-wireless/gnome-bluetooth:3[introspection]
	optfeature "greetd service" gui-libs/greetd
	optfeature "cover art caching (MPRIS service)" gnome-base/gvfs
	optfeature "network service" net-misc/networkmanager[introspection]
	optfeature "notifications service" x11-libs/libnotify[introspection]
	optfeature "power profiles service" sys-power/power-profiles-daemon
	optfeature "system tray service" dev-libs/libdbusmenu[gtk3,introspection]
	optfeature "Utils.fetch feature" net-libs/libsoup:3.0[introspection]
}
