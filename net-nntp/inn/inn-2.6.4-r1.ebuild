# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit optfeature perl-functions python-single-r1 systemd verify-sig

DESCRIPTION="InterNetNews -- the Internet meets Netnews"
HOMEPAGE="https://www.eyrie.org/~eagle/software/inn/"
SRC_URI="https://archives.eyrie.org/software/${PN}/${P}.tar.gz
	verify-sig? ( https://archives.eyrie.org/software/${PN}/${P}.tar.gz.sha256.asc )"

LICENSE="BSD BSD-2 BSD-4 GPL-2+ ISC MIT RSA powell public-domain"
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
RDEPEND="${DEPEND}
	virtual/sendmail
"
BDEPEND="
	sys-devel/flex
	app-alternatives/yacc
	verify-sig? ( sec-keys/openpgp-keys-russallbery )
"

DOCS=( ChangeLog CONTRIBUTORS HACKING INSTALL NEWS README TODO )

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
		--prefix="${EPREFIX}"/opt/${PN}
		--libdir="${EPREFIX}"/usr/$(get_libdir)/${PN}
		--includedir="${EPREFIX}"/usr/include
		--sysconfdir="${EPREFIX}"/etc/news

		--with-db-dir="${EPREFIX}"/var/db/news
		--with-doc-dir="${EPREFIX}"/usr/share/doc/${PF}
		--with-http-dir="${EPREFIX}"/usr/share/${PN}/http
		--with-libperl-dir=$(perl_get_vendorlib)
		--with-log-dir="${EPREFIX}"/var/log/${PN}
		--with-run-dir="${EPREFIX}"/run/news
		--with-spool-dir="${EPREFIX}"/var/spool/news
		--with-tmp-dir="${EPREFIX}"/var/tmp/news

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
	# elif use bzip2; then
	#	econf_args+=( --with-log-compress=bzip2 )
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

	keepdir /var/log/inn/OLD
	keepdir /var/tmp/news
	keepdir /var/spool/news/{archive,articles,incoming/bad,innfeed,outgoing,overview}

	find "${ED}" -name '*.la' -delete || die
	rm "${ED}"/usr/share/doc/${PF}/{GPL,LICENSE} || die
	rm -r "${ED}"/run || die

	# collision with sys-apps/man-pages
	mv "${ED}"/usr/share/man/man3/{list,inn-list}.3 || die

	doenvd "${FILESDIR}"/30inn
	newinitd "${FILESDIR}"/ovdb.initd ovdb
	for svc in cnfsstat innd innwatch; do
		newinitd "${FILESDIR}"/${svc}.initd ${svc}
		newconfd "${FILESDIR}"/${svc}.confd ${svc}
	done

	systemd_dounit "${FILESDIR}"/innd.service
}

pkg_postinst() {
	if use perl; then
		optfeature "controlchan program" dev-perl/MIME-tools
		optfeature "innreport script" dev-perl/GD
		optfeature "send-uucp backend" net-misc/taylor-uucp
	fi
}
