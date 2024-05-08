# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit font

DESCRIPTION="Fonts from the Warframe game"
HOMEPAGE="https://www.warframe.com/news/warframe-fansite-kit"
SRC_URI="
	https://m.box.com/file/401032406918/download?shared_link=https%3A%2F%2Fdigitalextremesltd.app.box.com%2Fs%2Fvh2u41yhdlgp3girffucbynadoi33173 -> Corpus.ttf
	https://m.box.com/file/401037009816/download?shared_link=https%3A%2F%2Fdigitalextremesltd.app.box.com%2Fs%2Fvh2u41yhdlgp3girffucbynadoi33173 -> CorpusBold.ttf
	https://m.box.com/file/401042823306/download?shared_link=https%3A%2F%2Fdigitalextremesltd.app.box.com%2Fs%2Fvh2u41yhdlgp3girffucbynadoi33173 -> Grineer.ttf
	https://m.box.com/file/302545392046/download?shared_link=https%3A%2F%2Fdigitalextremesltd.app.box.com%2Fs%2Fvh2u41yhdlgp3girffucbynadoi33173 -> Solaris.ttf
"
S="${DISTDIR}"

LICENSE="Warframe-EULA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror"

FONT_S="${S}"
FONT_SUFFIX="ttf"
