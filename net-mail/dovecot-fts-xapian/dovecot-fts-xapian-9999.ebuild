# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Dovecot FTS plugin backed by Xapian"
HOMEPAGE="https://github.com/grosjo/fts-xapian"

if [ "$PV" = 9999 ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/grosjo/fts-xapian/"
else
	SRC_URI="https://github.com/grosjo/fts-xapian/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/fts-xapian-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"

IUSE="static-libs"

RDEPEND="
	dev-libs/icu:=
	>=dev-libs/xapian-1.4:=
	net-mail/dovecot:=
	"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
if [ "$PV" = 9999 ] ; then
	BDPEND="${BDEPEND}
		sys-devel/autoconf
		sys-devel/autoconf-archive
	"
fi

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--with-dovecot="${EPREFIX}/usr/$(get_libdir)/dovecot" \
		$( use_enable static-libs static )
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
