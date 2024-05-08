# Copyright 2001-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The mailx utility from CentOS"
HOMEPAGE="https://www.debian.org/"
SRC_URI="https://yorune.pl/gentoo/${CATEGORY}/${PN}/${PN}_${PVR}.orig.tar.gz http://ftp.debian.org/debian/pool/main/h/${PN}/${PN}_${PVR}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-libs/liblockfile
		dev-libs/libbsd
		sys-libs/binutils-libs
		virtual/mta
		mail-client/mailx-support
		dev-libs/openssl"

RDEPEND="${DEPEND}
		!virtual/mailx
		!mail-client/nail
		!net-mail/mailutils
		!mail-client/mailx"

src_prepare() {
	eapply -p1 "${FILESDIR}/${PN}-${PVR}-fixes-1.patch"
	eapply -p1 "${FILESDIR}/${PN}-${PVR}-enable-ldflags.patch"
	eapply_user
}

src_compile(){
	sed 's@<openssl@<openssl-1.0/openssl@' -i openssl.c fio.c makeconfig
	emake LDFLAGS="${LDFLAGS}" LDFLAGS+="-L /usr/lib/openssl-1.0/" SENDMAIL=/usr/sbin/sendmail
}

src_install(){
	emake PREFIX="${D}/usr" SYSCONFDIR="${D}/etc" UCBINSTALL="/usr/bin/install" install
	install -v -m755 -d     "${D}/usr/share/doc/heirloom-mailx-12.5"
	install -v -m644 README "${D}/usr/share/doc/heirloom-mailx-12.5"
}
