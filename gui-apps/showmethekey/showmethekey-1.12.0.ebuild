# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson

DESCRIPTION="Show keys you typed on screen."
HOMEPAGE="https://showmethekey.alynx.one/"
SRC_URI="https://github.com/AlynxZhou/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib
	dev-libs/json-glib
	dev-libs/libevdev
	dev-libs/libinput
	dev-util/gtk-update-icon-cache
	gui-libs/gtk:4
	gui-libs/libadwaita
	virtual/udev
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i 's/gtk4-update-icon-/gtk-update-icon-/g' meson.build || die
}
