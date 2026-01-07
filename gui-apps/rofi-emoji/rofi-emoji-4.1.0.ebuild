# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Emoji selector plugin for Rofi"
HOMEPAGE="https://github.com/Mange/rofi-emoji"
SRC_URI="https://github.com/Mange/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
    gui-apps/rofi
    x11-libs/cairo
    dev-libs/glib:2
    test? ( dev-libs/check )
"
RDEPEND="${DEPEND}
    gui-apps/wtype
    gui-apps/wl-clipboard
"
BDEPEND="
    virtual/pkgconfig
"

src_prepare() {
    default
    eautoreconf
}
