# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Free On-line Dictionary of Computing for dict"
HOMEPAGE="https://foldoc.org"
SRC_URI="https://web.archive.org/web/20180405153121/http://foldoc.org/Dictionary -> ${P}.txt"
S="${WORKDIR}"
LICENSE="FDL-1.1+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-text/dictd-1.13.0-r3"
BDEPEND="${RDEPEND}"

src_unpack() {
	cp "${DISTDIR}/${A}" foldoc.txt || die
}

src_prepare() {
	eapply_user
	sed -e '/^$/{N;s/\n\([^\t]\+\)/\1/g;T;h;n;d}' -i foldoc.txt || die
}

src_compile() {
	tail -n +3 foldoc.txt | dictfmt -u "$HOMEPAGE/Dictionary" \
		-s "The Free On-line Dictionary of Computing (version ${PV})" \
		--utf8 \
		-f foldoc || die
	dictzip foldoc.dict || die
}

src_install() {
	insinto /usr/share/dict
	doins foldoc.dict.dz foldoc.index
}

pkg_postrm() {
	elog "You must unregister ${PN} and restart your dictd server before the"
	elog "dictionary is completely removed.  If you are using OpenRC, both tasks may be"
	elog "accomplished by running '/etc/init.d/dictd restart'."
}
