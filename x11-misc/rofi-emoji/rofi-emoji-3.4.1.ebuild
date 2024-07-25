# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Emoji selector plugin for Rofi"
HOMEPAGE="https://github.com/Mange/rofi-emoji"
SRC_URI="https://github.com/Mange/rofi-emoji/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="wayland"

DEPEND="
	!wayland? ( x11-misc/rofi )
	wayland? ( gui-apps/rofi-wayland )
"
RDEPEND="
	${DEPEND}
	!wayland? (
		|| ( x11-misc/xsel x11-misc/xclip x11-misc/copyq )
		x11-misc/xdotool
	)
	wayland? (
		gui-apps/wl-clipboard
		gui-apps/wtype
	)
"

src_prepare() {
	default
	eautoreconf -i
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
