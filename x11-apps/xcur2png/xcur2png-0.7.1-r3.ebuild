# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Convert X cursors to PNG images"
HOMEPAGE="https://github.com/eworm-de/xcur2png"
SRC_URI="https://github.com/eworm-de/xcur2png/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/libpng:=
	x11-libs/libXcursor
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf # bug 937784
}

src_configure() {
	append-cflags "-std=gnu89" # bug 916457
	default
}
