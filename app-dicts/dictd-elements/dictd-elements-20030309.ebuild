# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Jay Kominek's database of the elements for dict"
HOMEPAGE="http://www.dict.org"
SRC_URI="https://web.archive.org/web/20121223051336/http://www.miranda.org:80/~jkominek/elements/elements.db -> ${P}.db"
S="$WORKDIR"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-text/dictd-1.5.5"
BDEPEND="${RDEPEND}"

src_unpack() {
	cp "${DISTDIR}/${A}" elements.db || die
}

src_prepare() {
	eapply_user
	sed -e '/^%h/{h;n;n;s/Symbol: //;T;x;G;s/\n/ /}' -i elements.db
	sed -e '/^%h/{N;N;s/%h.*\n%d\n\(%h.*\)/\1\n%d/}' -i elements.db
}

src_compile() {
	dictfmt -u "${SRC_URI% ->*}" \
		-s "Jay Kominek's Elements database (version $PV)" \
		--headword-separator " " \
		--columns 80 \
		-p elements \
		< elements.db
	dictzip elements.dict
}

src_install() {
	insinto /usr/share/dict
	doins elements.dict.dz elements.index
}

pkg_postrm() {
	elog "You must unregister ${PN} and restart your dictd server before the"
	elog "dictionary is completely removed.  If you are using OpenRC, both tasks may be"
	elog "accomplished by running '/etc/init.d/dictd restart'."
}
