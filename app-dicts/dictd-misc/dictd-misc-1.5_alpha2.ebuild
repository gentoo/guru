# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPV="${PV/_alpha/A-}"
MYPV2="$(ver_cut 1-3 ${MYPV} )"

DESCRIPTION="Hitchcock's and Easton's Bible Dictionaries"
HOMEPAGE="http://www.dict.org"
SRC_URI="
	https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/dict-misc/${MYPV}/dict-misc_${MYPV2}.orig.tar.gz
	https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/dict-misc/${MYPV}/dict-misc_${MYPV}.diff.gz
"
S="${WORKDIR}/dict-misc-${MYPV2}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=app-text/dictd-1.13.0-r3"
RDEPEND="${BDEPEND}"

PATCHES=( "${WORKDIR}/dict-misc_${MYPV}.diff" )

src_compile() {
	cat easton/easton-info.txt easton/T*.html \
		| sed 's,<A HREF=[^>]*>\([^<]*\).*</A>,{\1},g' \
		| sed 's,\([A-Z][A-Z]*\) .T000[0-9]*,{\1},g' \
	| dictfmt -e \
		-u ftp://ccel.wheaton.edu/ebooks/HTML/e/easton/ebd/ \
		-s "Easton's 1897 Bible Dictionary" easton || die

	dictzip -v easton.dict || die

	dictfmt -h \
		-u ftp://ccel.wheaton.edu/ebooks/HTML/bible_names/bible_names.txt \
		-s "Hitchcock's Bible Names Dictionary (late 1800's)" \
	hitchcock < bible_names.txt || die

	dictzip -v hitchcock.dict || die
}

src_install() {
	insinto "/usr/share/dict"
	doins hitchcock.{index,dict.dz}
	doins easton.{index,dict.dz}
	dodoc "easton/easton-info.txt"
}
