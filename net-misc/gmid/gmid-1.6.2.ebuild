# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SSL_DAYS=36500
inherit ssl-cert toolchain-funcs

DESCRIPTION="Simple and secure Gemini server"
HOMEPAGE="https://www.omarpolo.com/pages/gmid.html"
SRC_URI="https://git.omarpolo.com/${PN}/snapshot/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+seccomp test"
RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}"/${P}-make-pidfile.patch )

DEPEND="
	acct-user/gemini
	dev-libs/libevent
	dev-libs/libretls
"
BDEPEND="
	sys-devel/flex
	virtual/pkgconfig
	virtual/yacc
"
RDEPEND="${DEPEND}"

DOCS=( README.md ChangeLog )

src_prepare() {
	default

	if use seccomp && has usersandbox ${FEATURES} ; then
		eapply "${FILESDIR}"/${P}-disable-runtime-test.patch
	fi
}

src_configure() {
	local conf_args

	# note: not an autoconf configure script
	conf_args=(
		CC="$(tc-getCC)"
		PREFIX="${EPREFIX}"/usr/share
		BINDIR="${EPREFIX}"/usr/bin
		CFLAGS="${CFLAGS}"
		LDFLAGS="${LDFLAGS} -ltls -lssl -lcrypto -levent"
	)
	if ! use seccomp ; then
		conf_args+=( --disable-sandbox )
	fi

	./configure "${conf_args[@]}" || die
}

src_compile() {
	emake gmid
	if use test ; then
		emake gg
		emake -C regress puny-test testdata iri_test
	fi
}

src_test() {
	emake regress
}

src_install() {
	default

	insinto /etc/gmid
	doins "${FILESDIR}"/gmid.conf

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
