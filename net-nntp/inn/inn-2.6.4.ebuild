# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit optfeature python-single-r1 verify-sig

DESCRIPTION="InterNetNews -- the Internet meets Netnews"
HOMEPAGE="https://www.eyrie.org/~eagle/software/inn/"
SRC_URI="https://archives.eyrie.org/software/${PN}/${P}.tar.gz
	verify-sig? ( https://archives.eyrie.org/software/${PN}/${P}.tar.gz.sha256.asc )"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="berkdb gzip kerberos keywords largefile low-memory +perl +python sasl ssl systemd zlib"
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
	?? ( low-memory largefile )
" # ?? ( bzip2 gzip )

DEPEND="
	app-crypt/gnupg
	sys-libs/pam
	virtual/libcrypt:=
	virtual/sendmail
	!berkdb? ( sys-libs/gdbm:= )
	berkdb? ( sys-libs/db:* )
	kerberos? ( app-crypt/mit-krb5 )
	perl? ( dev-lang/perl:= )
	python? ( ${PYTHON_DEPS} )
	sasl? ( dev-libs/cyrus-sasl:2 )
	ssl? ( dev-libs/openssl:= )
	systemd? ( sys-apps/systemd:= )
	zlib? ( sys-libs/zlib:= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/flex
	virtual/yacc
	verify-sig? ( sec-keys/openpgp-keys-russallbery )
"

DOCS=(
	ChangeLog CONTRIBUTORS HACKING INSTALL NEWS README TODO
	doc/{checklist,external-auth,FAQ} doc/history{,-innfeed}
	doc/hook-{perl,python} doc/{IPv6-info,sample-control}
	doc/config-{design,semantics,syntax}
)

VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}/usr/share/openpgp-keys/russallbery.asc"

src_unpack() {
	if use verify-sig; then
		pushd "${DISTDIR}" || die
		verify-sig_verify_signed_checksums \
			${P}.tar.gz.sha256.asc sha256 ${P}.tar.gz
		popd || die
	fi

	unpack ${P}.tar.gz
}

src_configure() {
	econf_args=(
		--prefix=/opt/${PN}
		$(use_enable keywords)
		$(use_enable largefile largefiles)
		$(use_enable low-memory tagged-hash)
		$(use_with berkdb bdb)
		$(use_with kerberos krb5)
		$(use_with perl)
		$(use_with python)
		$(use_with sasl)
		$(use_with ssl openssl)
		$(use_with zlib)
	)

	if use gzip; then
		econf_args+=( --with-log-compress=gzip )
	else
		econf_args+=( --with-log-compress=cat )
	fi

	econf "${econf_args[@]}"
}

src_compile() {
	emake -j1
}

src_test() {
	emake -j1 check
}

src_install() {
	default

	# collision with sys-apps/man-pages
	mv "${ED}"/usr/share/man/man3/{list,inn-list}.3 || die

	rm -r "${ED}"/opt/${PN}/{db,doc} || die
}

pkg_postinst() {
	if use perl; then
		optfeature "controlchan program" dev-perl/MIME-tools
		optfeature "innreport script" dev-perl/GD
		optfeature "send-uucp backend" net-misc/taylor-uucp
	fi
}
