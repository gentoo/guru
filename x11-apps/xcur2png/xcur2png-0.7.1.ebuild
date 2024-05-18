# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Convert X cursors to PNG images"
HOMEPAGE="https://github.com/eworm-de/xcur2png"
SRC_URI="https://github.com/eworm-de/xcur2png/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/libpng
	x11-libs/libXcursor
"
