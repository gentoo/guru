# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Unlock GnuPG keys on login"
HOMEPAGE="https://github.com/cruegge/pam-gnupg"
SRC_URI="https://github.com/cruegge/pam-gnupg/archive/refs/tags/v${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
>=sys-libs/pam-1.5.1_p20210622-r1
>=app-crypt/gnupg-2.2.33-r1
"

src_configure() {
	eautoreconf
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-moduledir=/$(get_libdir)/security \
		--mandir=/usr/share/man || die
}
