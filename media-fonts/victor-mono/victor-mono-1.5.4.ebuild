# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="A free programming font with cursive italics and ligatures"
HOMEPAGE="https://rubjo.github.io/victor-mono/"
SRC_URI="https://github.com/rubjo/victor-mono/raw/v${PV}/public/VictorMonoAll.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+otf ttf"
REQUIRED_USE="|| ( otf ttf )"
RESTRICT="binchecks strip"

BDEPEND="app-arch/unzip"

FONT_CONF=(
	"${FILESDIR}/66-victor-mono.conf"
)

src_install() {
	use otf && { FONT_S="${S}/OTF"; FONT_SUFFIX="otf"; }
	use ttf && { FONT_S="${S}/TTF"; FONT_SUFFIX="ttf"; }

	font_src_install
}
