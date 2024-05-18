# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN^}"

inherit font

DESCRIPTION="Unicode font for Latin, IPA Extensions, Greek, Cyrillic and many Symbol Blocks"
HOMEPAGE="https://web.archive.org/web/20140913154759/http://users.teilar.gr/~g1951d"
SRC_URI="
	https://web.archive.org/web/20140913154759if_/http://users.teilar.gr/~g1951d/Symbola.zip -> ${P}.zip
	https://web.archive.org/web/20140913154759if_/http://users.teilar.gr/~g1951d/Symbola.pdf -> ${P}.pdf
"

S="${WORKDIR}"

LICENSE="Unicode_Fonts_for_Ancient_Scripts"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

DOCS=(
	"${DISTDIR}/${P}.pdf"
	"${MY_PN}.docx"
)
HTML_DOCS=( "${MY_PN}.htm" )
FONT_S="${S}"
FONT_SUFFIX="ttf"
