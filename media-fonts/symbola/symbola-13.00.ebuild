# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

MY_PN="${PN^}"

DESCRIPTION="Unicode font for Latin, IPA Extensions, Greek, Cyrillic and many Symbol Blocks"
HOMEPAGE="https://dn-works.com/ufas/"
SRC_URI="https://dn-works.com/wp-content/uploads/2020/UFAS-Fonts/Symbola.zip -> ${P}.zip"

S="${WORKDIR}"

LICENSE="UFAS"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"

BDEPEND="app-arch/unzip"

FONT_S="${S}"

DOCS=(
	"${MY_PN}.pdf"
	"${MY_PN}.odt"
)
FONT_SUFFIX="otf"
