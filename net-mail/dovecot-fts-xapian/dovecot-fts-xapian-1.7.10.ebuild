# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Dovecot FTS plugin backed by Xapian"
HOMEPAGE="https://github.com/grosjo/fts-xapian"
SRC_URI="https://github.com/grosjo/fts-xapian/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fts-xapian-${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="static-libs"

RDEPEND="
	dev-libs/icu:=
	>=dev-libs/xapian-1.4:=
	net-mail/dovecot:=
	"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/bug-887887_allow-O2-override.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# Disable hardening so CFLAGS are left up to the Gentoo user
	# https://bugs.gentoo.org/888751
	econf \
		--enable-hardening=no \
		--with-dovecot="${EPREFIX}/usr/$(get_libdir)/dovecot" \
		$( use_enable static-libs static )
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
