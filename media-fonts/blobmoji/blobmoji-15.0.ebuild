# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Noto Emoji with extended Blob support"
HOMEPAGE="https://github.com/C1710/blobmoji"
SRC_URI="https://github.com/C1710/blobmoji/releases/download/v${PV}/${PN^}.ttf -> ${P}.ttf"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

FONT_SUFFIX="ttf"
FONT_CONF=( "${FILESDIR}"/75-blobmoji-fallback.conf )

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/${PN}.${FONT_SUFFIX}" || die
}
