# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The Jargon File for dict"
HOMEPAGE="http://www.catb.org/~esr/jargon/index.html"
SRC_URI="http://www.catb.org/~esr/jargon/oldversions/jarg${PV//.}.txt"
S="${WORKDIR}"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-text/dictd-1.5.5"
BDEPEND="${RDEPEND}"

src_unpack() {
	cp "${DISTDIR}/${A}" jargon.txt || die
}

src_prepare() {
	eapply_user
	# This sed script works for all versions >=3.0.0 until <4.4.0 (when the
	# entire format changes).
	sed \
		-e '/^The Jargon Lexicon/,/:(Lexicon Entries End Here):/!{w jargon.doc' -e 'd}' \
		-e 's/^    \s*/\t/' -e 's/^   //' \
		-e 's/\([^\t]\)\t/\1  /g' \
		-e 's/^\(:[^:]*:\)\s*/\1/' \
		-e '/^= . =/,/^$/d' \
		-e '/^\S/{: l;N;s/\n *\(.\)/ \1/g;t l}' \
		-e 's/\([^A-Za-z ]\) \+\([2-9][0-9]\?\|1[0-9]\)\.\( \+\|$\)/\1\n\n\2. /g' \
		-e 's/^\([2-9][0-9]\?\|1[0-9]\)\.\( \+\|$\)/\n\1. /g' \
		-i jargon.txt || die
}

src_compile() {
	dictfmt -u "$SRC_URI" \
		-s "The Jargon File (version $PV)" \
		--columns 80 \
		-j jargon \
		< jargon.txt || die
	dictzip jargon.dict || die
}

src_install() {
	newdoc jargon.doc jargon.txt
	insinto /usr/share/dict
	doins jargon.dict.dz jargon.index
}

pkg_postrm() {
	elog "You must unregister ${PN} and restart your dictd server before the"
	elog "dictionary is completely removed.  If you are using OpenRC, both tasks may be"
	elog "accomplished by running '/etc/init.d/dictd restart'."
}
