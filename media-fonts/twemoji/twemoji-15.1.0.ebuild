# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

BUILD_DATE="2025-01-05_14-29"
DESCRIPTION="Color emoji font with a flat visual style, designed and used by Twitter"
HOMEPAGE="https://git.sr.ht/~whynothugo/twemoji.ttf/"
SRC_URI="https://mirror.whynothugo.nl/twemoji.ttf/${BUILD_DATE}/Twemoji-${PV}.ttf"
S="${WORKDIR}"

LICENSE="Apache-2.0 CC-BY-4.0 MIT OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

FONT_SUFFIX="ttf"
FONT_CONF=( "${FILESDIR}"/75-${PN}.conf )

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${PN}.${FONT_SUFFIX}" || die
}
