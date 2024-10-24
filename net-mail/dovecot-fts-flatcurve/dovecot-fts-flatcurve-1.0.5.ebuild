# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Dovecot FTS plugin to enable message indexing using Xapian"
HOMEPAGE="https://github.com/slusarz/dovecot-fts-flatcurve"
SRC_URI="https://github.com/slusarz/dovecot-fts-flatcurve/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="textcat"

DEPEND="
	<net-mail/dovecot-2.4.0:=[stemmer,textcat?]
	>=dev-libs/xapian-1.4.0
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed \
		-e 's/CFLAGS="$CFLAGS $EXTRA_CFLAGS"/CFLAGS=""/' \
		-e 's/CFLAGS="$CFLAGS /CFLAGS="/' \
		-i configure.ac || die

	eautoreconf
}

src_configure() {
	econf --with-dovecot="${EPREFIX}/usr/$(get_libdir)/dovecot"
}

src_install() {
	default
	find "${D}" -name "*.la" -delete

	dodoc "${FILESDIR}/90-fts.conf"
}

pkg_postinst() {
	elog "For configuration, report to https://slusarz.github.io/dovecot-fts-flatcurve/configuration.html"
	elog "The steps are as follows : "
	elog "Insert 'mail_plugins = $mail_plugins fts fts_flatcurve' in /etc/dovecot/conf.d/10-mail.conf"
	elog "Set configuration in /etc/dovecot/conf.d/90-fts.conf"
	elog "See example : /usr/share/doc/${P}/90-fts.conf.bz2"
}
