# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Font for sitelen pona, a script for toki pona"
HOMEPAGE="http://musilili.net/linja-pona https://github.com/janSame/linja-pona"
SRC_URI="https://drive.google.com/uc?export=download&id=1ukFvjXku_0Sdqq3u4oHlPLhTlR2J9b3I -> ${P}.otf"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

FONT_SUFFIX="otf"

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${PN}.${FONT_SUFFIX}" || die
}
