# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SSL_DAYS=36500
SSL_CERT_MANDATORY=1
inherit ssl-cert systemd toolchain-funcs

DESCRIPTION="Simple and secure Gemini server"
HOMEPAGE="https://gmid.omarpolo.com"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/omar-polo/${PN}.git https://git.omarpolo.com/${PN}"
	inherit git-r3
else
	SRC_URI="https://git.omarpolo.com/${PN}/snapshot/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD ISC MIT"
SLOT="0"
IUSE="+seccomp test"
RESTRICT="!test? ( test )"

DEPEND="
	acct-user/gemini
	dev-libs/imsg-compat
	dev-libs/libbsd
	dev-libs/libevent
	dev-libs/libretls
"
BDEPEND="
	virtual/pkgconfig
	virtual/yacc
"
RDEPEND="${DEPEND}"

DOCS=( README.md ChangeLog contrib/README )

src_prepare() {
	default

	sed \
		-e "s:/usr/local/bin/gmid:/usr/bin/gmid:" \
		-e "s:/etc/gmid.conf:/etc/gmid/gmid.conf:" \
		-i contrib/gmid.service || die
}

src_configure() {
	local conf_args
	tc-export CC

	# note: not an autoconf configure script
	conf_args=(
		PREFIX="${EPREFIX}"/usr/share
		BINDIR="${EPREFIX}"/usr/bin
		$(use_enable seccomp sandbox)
	)

	./configure "${conf_args[@]}" || die

	if use seccomp && has usersandbox ${FEATURES} ; then
		export SKIP_RUNTIME_TESTS=1
	fi
}

src_compile() {
	emake gmid
	if use test ; then
		emake -C regress gg data puny-test fcgi-test
	fi
}

src_test() {
	emake regress
}

src_install() {
	default

	insinto /etc/gmid
	doins "${FILESDIR}"/gmid.conf

	insinto /usr/share/vim/vimfiles
	doins -r contrib/vim/*

	systemd_dounit contrib/gmid.service
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
