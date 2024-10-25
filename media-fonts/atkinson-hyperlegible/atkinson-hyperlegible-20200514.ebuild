# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Braille Institute's Atkinson Hyperlegible font."
HOMEPAGE="https://www.brailleinstitute.org/freefont/"

MY_PV="2020-0514"
SRC_URI="https://www.brailleinstitute.org/atkinson-hyperlegible-font/Atkinson-Hyperlegible-Font-Print-and-Web-${MY_PV}.zip -> ${P}.zip"
S="${WORKDIR}/Atkinson-Hyperlegible-Font-Print-and-Web-${MY_PV}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong ~riscv ~x86"

IUSE="otf +ttf"
REQUIRED_USE="^^ ( otf ttf )"

BDEPEND="app-arch/unzip"

FONT_SUFFIX=""

src_install() {
	if use otf; then
		FONT_SUFFIX+="otf"
		FONT_S=( "Print Fonts/" )
	fi
	if use ttf; then
		FONT_SUFFIX+="ttf"
		FONT_S=( "Web Fonts/TTF" )
	fi
	font_src_install
}
