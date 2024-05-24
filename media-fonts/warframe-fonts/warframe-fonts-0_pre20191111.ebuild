# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit font

DESCRIPTION="Fonts from the Warframe game"
HOMEPAGE="https://www.warframe.com/news/warframe-fansite-kit"
SRC_URI="
	https://www.dropbox.com/scl/fo/el9i8ltoms44id3wt3swv/h/Languages/Corpus.ttf?dl=1&rlkey=3ehhk98vupze6if64gl3lia08 -> Corpus.ttf
	https://www.dropbox.com/scl/fo/el9i8ltoms44id3wt3swv/h/Languages/CorpusBold.ttf?dl=1&rlkey=3ehhk98vupze6if64gl3lia08 -> CorpusBold.ttf
	https://www.dropbox.com/scl/fo/el9i8ltoms44id3wt3swv/h/Languages/Grineer.ttf?dl=1&rlkey=3ehhk98vupze6if64gl3lia08 -> Grineer.ttf
	https://www.dropbox.com/scl/fo/el9i8ltoms44id3wt3swv/h/Languages/Solaris.ttf?dl=1&rlkey=3ehhk98vupze6if64gl3lia08 -> Solaris.ttf
"
S="${DISTDIR}"

LICENSE="Warframe-EULA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror"

FONT_S="${S}"
FONT_SUFFIX="ttf"
