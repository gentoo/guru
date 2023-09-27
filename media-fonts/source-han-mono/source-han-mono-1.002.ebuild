# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Pan-CJK OpenType/CFF mono font family"
HOMEPAGE="https://github.com/adobe-fonts/source-han-mono"
SRC_URI="https://github.com/adobe-fonts/${PN}/releases/download/${PV}/SourceHanMono.ttc -> ${P}.ttc"
S=${WORKDIR}

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos"

FONT_SUFFIX="ttc"
RESTRICT="binchecks strip"

BDEPEND="app-arch/unzip"

src_prepare() {
	cp "${DISTDIR}"/${P}.ttc . || die
	default
}
