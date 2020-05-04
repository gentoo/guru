# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

VERSION="VERSION_${PV//./_}"

DESCRIPTION="RPKI client implementation"
HOMEPAGE="https://github.com/kristapsdz/rpki-client"
SRC_URI="https://github.com/kristapsdz/${PN}/archive/${VERSION}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	acct-group/_rpki-client
	acct-user/_rpki-client
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${VERSION}"

src_configure() {
	./configure CPPFLAGS="`pkg-config --cflags openssl`" \
		LDFLAGS="`pkg-config --libs-only-L openssl`" \
		LDADD="`pkg-config --libs openssl` -lresolv"
}

src_install() {
	emake DESTDIR="${D}" BINDIR="/usr/bin" MANDIR="/usr/share/man" install
	insinto /usr/share/${PN}
	doins tals/*
	keepdir /var/cache/${PN}/
	fowners -R _rpki-client /var/cache/${PN}/
}
