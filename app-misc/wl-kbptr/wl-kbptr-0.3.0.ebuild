# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Control the mouse pointer with the keyboard on Wayland"
HOMEPAGE="https://github.com/moverest/wl-kbptr"
SRC_URI="https://github.com/moverest/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	app-alternatives/ninja
	dev-build/meson
"

src_compile() {
	meson_src_compile
}

src_install() {
	meson_install
}
