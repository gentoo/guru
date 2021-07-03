# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Devil's Dictionary for dict"
HOMEPAGE="https://www.gutenberg.org/ebooks/972"
SRC_URI="https://www.gutenberg.org/files/972/972-0.zip -> ${P}.zip"
S="$WORKDIR"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-text/dictd-1.13.0-r3"
BDEPEND="
	${RDEPEND}
	app-arch/unzip
	app-text/dos2unix
"

PATCHES=( "${FILESDIR}/format.patch" )

src_prepare() {
	dos2unix 972-0.txt || die
	default

	sed \
		-e 's/\r//g' \
		-e "/^ *THE DEVIL'S DICTIONARY/,/^End of Project Gutenberg's The Devil's Dictionary/!{w COPYING.gutenberg" -e 'd}' \
		-e '/^\S/{: l;N;s/\n *\(.\)/ \1/g;t l}' \
		-e "s/^\\([A-Zor .'?-]*[^,A-Zor .'?-]\\)/ \1/" \
		-e '/^ /y/,/\a/' \
		-i 972-0.txt || die
}

src_compile() {
	head -n -6 972-0.txt | dictfmt -u "${SRC_URI% ->*}" \
		-s "The Devil's Dictionary (2021-06-27 Project Gutenberg version)" \
		--headword-separator " or " \
		--columns 80 \
		-h devils || die
	sed -e 'y/\a/,/' -i devils.dict || die
	dictzip devils.dict || die
}

src_install() {
	insinto /usr/share/dict
	doins devils.dict.dz devils.index
}
