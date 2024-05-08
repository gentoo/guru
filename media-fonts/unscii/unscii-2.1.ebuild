# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FONT_SUFFIX="otf pcf ttf"

inherit font

DESCRIPTION="Set of bitmapped Unicode fonts based on classic system fonts"
HOMEPAGE="http://viznut.fi/unscii/"
SRC_URI="http://viznut.fi/unscii/${P}-src.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}-src"

LICENSE="
	public-domain
	unicode? ( GPL-2 )
"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicode"

RDEPEND="media-libs/sdl-image"
DEPEND="
	${RDEPEND}
	dev-lang/perl
	media-gfx/fontforge
	x11-apps/bdftopcf
	unicode? ( media-fonts/unifont[utils] )
"

DOCS=( ${PN}.txt )

src_prepare() {
	default

	sed -i \
		-e 's;CC=.*;CC ?= gcc;' \
		-e 's;$(CC) ;&$(CFLAGS) ;' \
		-e 's;$(CC) .* -o .*;& $(LDFLAGS);' \
		Makefile || die
}

src_install() {
	font_src_install
	dobin bm2uns
}
