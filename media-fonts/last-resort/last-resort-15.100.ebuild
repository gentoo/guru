# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION='A collection of glyphs used as the backup of "last resort" to any other font'
HOMEPAGE="https://github.com/unicode-org/last-resort-font"
SRC_URI="https://github.com/unicode-org/${PN}-font/releases/download/${PV}/LastResortHE-Regular.ttf -> ${P}.ttf"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

FONT_SUFFIX="ttf"

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${PN}.${FONT_SUFFIX}" || die
}
