# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Turn-based, old style with minimum graphic, full game, 5 MB size"
HOMEPAGE="http://akasoft.genliga.ru/index_e.php"

SRC_URI="https://archive.org/download/general.tar.xz/$P.tar.xz"

KEYWORDS="~amd64"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
RESTRICT="strip"

RDEPEND="
	~games-emulation/conty-1.25.2:0
"
# TODO add USE flag to be able to choolse local wine or wine-proton, against 1.4 GB dependency?

QA_PREBUILT="*"

src_install() {

	mkdir -p "$ED$/opt" || die

	mkdir "$ED/opt" || die
	mkdir -p "$ED/usr/bin/" || die
	cp -r "$PN" "$ED/opt/$PN" || die

	conty='conty-1.25.2'

	echo "cd /opt/$PN; $conty wine $PN; cd -" > "$ED/usr/bin/$PN"
	fperms +x "/usr/bin/$PN"
	# I tried this but on run error: "Problems during decoding OGG files" -
	# because I need to run from the directory of the game,
	# but cd does not works with exec
	# make_wrapper "$PN" "$conty wine /opt/$PN/$PN.exe /d /opt/$PN"

}

pkg_postinst() {
	einfo "More about the game:"
	einfo "See screenshots at http://akasoft.genliga.ru/rus/about.php"
	einfo "https://ru.wikipedia.org/wiki/Генерал_(игра)"
	einfo "https://www.wikidata.org/wiki/Q4043784"
	einfo "https://www.wikidata.org/wiki/Q4135303"
}
