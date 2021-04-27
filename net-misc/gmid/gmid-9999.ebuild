# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SSL_DEPS_SKIP=1
SSL_DAYS=36500

inherit ssl-cert toolchain-funcs

DESCRIPTION="Simple and secure Gemini server"
HOMEPAGE="https://www.omarpolo.com/pages/gmid.html"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://git.omarpolo.com/${PN}"
else
	SRC_URI="https://git.omarpolo.com/${PN}/snapshot/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE="libressl"

DEPEND="acct-user/gemini
	dev-libs/libevent
	!libressl? ( dev-libs/libretls )
	libressl? ( dev-libs/libressl )"
BDEPEND="sys-devel/flex
	virtual/yacc"
RDEPEND="${DEPEND}"

DOCS=( README.md ChangeLog )

src_configure() {
	# note: not an autoconf configure script
	./configure \
		CC="$(tc-getCC)" \
		PREFIX="${EPREFIX}"/usr/share \
		BINDIR="${EPREFIX}"/usr/bin \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS} -ltls -lssl -lcrypto -levent" || die
}

src_install() {
	default

	dodir /etc/gmid
	cp "${FILESDIR}"/gmid.conf "${ED}"/etc/gmid/gmid.conf || die

	newinitd "${FILESDIR}"/gmid.initd gmid
	newconfd "${FILESDIR}"/gmid.confd gmid

	keepdir /var/gemini/localhost
}

pkg_postinst() {
	if [[ ! -f "${EROOT}"/etc/ssl/${PN}/${PN}.key ]]; then
		install_cert /etc/ssl/${PN}/${PN}
		chown gemini:gemini "${EROOT}"/etc/ssl/${PN}/${PN}.{crt,csr,key,pem}
	fi

	einfo "This gemini server can be run as a user with zero configuration.\n"
	einfo "In order to use it with the init service you will need to generate a"
	einfo "self-signed TLS certificate and a key and set up the configuration"
	einfo "file (see man 1 gmid for details)."
}
