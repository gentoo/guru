# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SSL_DAYS=36500
SSL_CERT_MANDATORY=1
VERIFY_SIG_METHOD="signify"
inherit edo ssl-cert systemd toolchain-funcs verify-sig

DESCRIPTION="Simple and secure Gemini server"
HOMEPAGE="https://gmid.omarpolo.com"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://git.omarpolo.com/${PN} https://github.com/omar-polo/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/omar-polo/${PN}/releases/download/${PV}/${P}.tar.gz
		verify-sig? ( https://github.com/omar-polo/${PN}/releases/download/${PV}/${P}.sha256.sig )"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD ISC MIT"
SLOT="0"
IUSE="seccomp test"
RESTRICT="!test? ( test )"

DEPEND="
	acct-user/gemini
	dev-libs/libevent:=
	dev-libs/openssl:=
	!elibc_Darwin? ( dev-libs/libbsd )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	app-alternatives/yacc
	seccomp? ( sys-kernel/linux-headers )
"
if [[ ${PV} != 9999 ]]; then
	BDEPEND+="verify-sig? ( sec-keys/signify-keys-gmid:$(ver_cut 1-2) )"
fi

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/${PN}-$(ver_cut 1-2).pub"

DOCS=( README.md ChangeLog contrib/README )

# not an autoconf configure script
QA_CONFIG_IMPL_DECL_SKIP=( "*" )

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	else
		if use verify-sig; then
			# Too many levels of symbolic links
			cp "${DISTDIR}"/${P}.{sha256.sig,tar.gz} "${WORKDIR}" || die
			cd "${WORKDIR}" || die
			verify-sig_verify_signed_checksums \
				${P}.sha256.sig sha256 ${P}.tar.gz
		fi
		default
	fi
}

src_configure() {
	local conf_args
	tc-export CC

	# note: not an autoconf configure script
	conf_args=(
		--prefix="${EPREFIX}"/usr
		--mandir="${EPREFIX}"/usr/share/man
		--sysconfdir="${EPREFIX}"/etc
		--with-libtls=bundled
		$(use_enable seccomp sandbox)
	)
	edo ./configure "${conf_args[@]}"

	if use seccomp && has usersandbox ${FEATURES}; then
		export SKIP_RUNTIME_TESTS=1
	fi
}

src_install() {
	default

	insinto /etc/gmid
	newins "${FILESDIR}"/gmid.conf-r1 gmid.conf

	insinto /usr/share/vim/vimfiles
	doins -r contrib/vim/*

	systemd_dounit "${FILESDIR}"/gmid.service
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
