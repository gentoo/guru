# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A utility for creating static blogs"
HOMEPAGE="https://kristaps.bsd.lv/sblg/"
SRC_URI="https://kristaps.bsd.lv/sblg/snapshots/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="dev-libs/expat"
RDEPEND="${DEPEND}"

src_configure() {
	./configure PREFIX="${EPREFIX}/usr" MANDIR="${EPREFIX}/usr/share/man"
}

src_install() {
	emake DESTDIR="${D}" install

	if ! use examples; then
		rm -rf "${ED}/usr/share/${PN}/examples" || die
	fi
}
