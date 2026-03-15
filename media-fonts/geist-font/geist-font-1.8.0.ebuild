# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Geist is a new font family for Vercel"
HOMEPAGE="https://vercel.com/font"
SRC_URI="https://github.com/vercel/geist-font/releases/download/${PV}/${P}.zip"

S="${WORKDIR}/${P}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+geist +geistmono geistpixel +otf ttf"
REQUIRED_USE="|| ( geist geistmono geistpixel ) || ( otf ttf )"

DOCS="${WORKDIR}/${P}/OFL.txt"

BDEPEND="app-arch/unzip"

src_install() {
	local FONT_S_ARRAY=()
	local FONT_SUFFIX_LIST=""

	if use otf; then
		local FONT_S=()
		local FONT_SUFFIX="otf"

		use geist && { FONT_S+=( "${S}/fonts/Geist/otf" ); }
		use geistmono && { FONT_S+=( "${S}/fonts/GeistMono/otf" ); }
		use geistpixel && { FONT_S+=( "${S}/fonts/GeistPixel/otf" ); }

		font_src_install
	fi

	if use ttf; then
		local FONT_S=()
		local FONT_SUFFIX="ttf"

		use geist && { FONT_S+=( "${S}/fonts/Geist/ttf" ); }
		use geistmono && { FONT_S+=( "${S}/fonts/GeistMono/ttf" ); }
		use geistpixel && { FONT_S+=( "${S}/fonts/GeistPixel/ttf" ); }

		font_src_install
	fi
}
