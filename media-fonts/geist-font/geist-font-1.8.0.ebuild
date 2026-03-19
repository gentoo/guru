# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Geist is a new font family for Vercel"
HOMEPAGE="https://vercel.com/font"
SRC_URI="https://github.com/vercel/geist-font/releases/download/${PV}/${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+geist +geistmono geistpixel +otf ttf"
REQUIRED_USE="|| ( geist geistmono geistpixel ) || ( otf ttf )"

DOCS="${S}/OFL.txt"

BDEPEND="app-arch/unzip"

src_install() {
	local font suffix

	for font in Geist GeistMono GeistPixel; do
		use "${font,,}" || continue
		for suffix in otf ttf; do
			use "${suffix}" || continue
			FONT_SUFFIX="${suffix}"
			FONT_S="${S}/fonts/${font}/${suffix}"
			font_src_install
		done
	done
}
