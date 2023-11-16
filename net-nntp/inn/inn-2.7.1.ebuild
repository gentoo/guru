# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit optfeature perl-functions python-single-r1 systemd tmpfiles verify-sig

DESCRIPTION="InterNetNews - the Internet meets Netnews"
HOMEPAGE="
	https://www.isc.org/othersoftware/#INN
	https://www.eyrie.org/~eagle/software/inn/
	https://github.com/InterNetNews/inn
"
SRC_URI="https://downloads.isc.org/isc/${PN}/${P}.tar.gz
	verify-sig? ( https://downloads.isc.org/isc/${PN}/${P}.tar.gz.asc )"

LICENSE="BSD BSD-2 BSD-4 GPL-2+ ISC MIT RSA powell public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+bzip2 cancel-locks gzip kerberos low-memory python sasl sqlite ssl test zlib"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

DEPEND="
	app-crypt/gnupg
	dev-lang/perl:=
	sys-libs/gdbm:=
	sys-libs/pam
	virtual/libcrypt:=
	virtual/mta
	bzip2? ( app-alternatives/bzip2 )
	cancel-locks? ( net-libs/canlock:= )
	gzip? ( app-alternatives/gzip )
	kerberos? ( virtual/krb5 )
	python? ( ${PYTHON_DEPS} )
	sasl? ( dev-libs/cyrus-sasl:2 )
	sqlite? ( dev-db/sqlite:3 )
	ssl? ( dev-libs/openssl:= )
	zlib? ( sys-libs/zlib:= )
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-alternatives/lex
	app-alternatives/yacc
	dev-lang/perl
	virtual/pkgconfig
	test? ( dev-perl/Test-Pod )
	verify-sig? ( >=sec-keys/openpgp-keys-russallbery-20230000 )
"

DOCS=( CONTRIBUTORS HACKING INSTALL NEWS README TODO )

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/openpgp-keys/russallbery.asc"

src_configure() {
	econf_args=(
		UUSTAT="${EPREFIX}/usr/bin/uustat"
		inn_cv_compiler_c__g="no"
		inn_cv_compiler_c__O3="no"
		inn_cv_compiler_c__Werror="no"

		--prefix="${EPREFIX}"/opt/${PN}
		--includedir="${EPREFIX}"/usr/include
		--sysconfdir="${EPREFIX}"/etc/news

		--with-control-dir="${EPREFIX}"/usr/libexec/inn/control
		--with-db-dir="${EPREFIX}"/var/db/news
		--with-doc-dir="${EPREFIX}"/usr/share/doc/${PF}
		--with-filter-dir="${EPREFIX}"/usr/libexec/inn/filter
		--with-http-dir="${EPREFIX}"/usr/share/${PN}/http
		--with-libperl-dir="$(perl_get_vendorlib)"
		--with-log-dir="${EPREFIX}"/var/log/news
		--with-run-dir="${EPREFIX}"/run/news
		--with-spool-dir="${EPREFIX}"/var/spool/news
		--with-tmp-dir="${EPREFIX}"/var/tmp/news

		$(use_enable !low-memory largefiles)
		$(use_enable low-memory tagged-hash)
		$(use_with cancel-locks canlock)
		$(use_with kerberos krb5)
		$(use_with python)
		$(use_with sasl)
		$(use_with sqlite sqlite3)
		$(use_with ssl openssl)
		$(use_with zlib)
		--disable-hardening-flags
		--enable-keywords
		--with-perl
		--without-bdb # deprecated db
		--without-blacklist # FreeBSD-only
	)

	if use bzip2; then
		econf_args+=( --with-log-compress=bzip2 )
	elif use gzip; then
		econf_args+=( --with-log-compress=gzip )
	else
		econf_args+=( --with-log-compress=cat )
	fi

	econf "${econf_args[@]}"
}

src_install() {
	default

	keepdir /var/log/news/OLD
	keepdir /var/spool/news/{archive,articles,incoming/bad,innfeed,outgoing,overview}

	find "${ED}" -name '*.la' -delete || die
	rm "${ED}"/usr/share/doc/${PF}/{GPL,LICENSE} || die
	rm -r "${ED}"/run "${ED}"/var/tmp || die

	if [[ ${REPLACING_VERSIONS} ]]; then
		rm "${ED}"/var/db/news/* || die
	fi

	for svc in cnfsstat innwatch; do
		newinitd "${FILESDIR}"/${svc}.initd ${svc}
		newconfd "${FILESDIR}"/${svc}.confd ${svc}
	done
	newinitd "${FILESDIR}"/innd.initd-r1 innd
	newconfd "${FILESDIR}"/innd.confd innd

	if use sqlite; then
		newinitd "${FILESDIR}"/ovsqlite.initd ovsqlite
	fi

	newtmpfiles "${FILESDIR}"/inn.tmpfiles-r1 inn.conf
}

pkg_postinst() {
	optfeature "controlchan script" dev-perl/MIME-tools
	optfeature "innreport script" dev-perl/GD
	optfeature "send-uucp backend" net-misc/taylor-uucp

	if use sqlite; then
		optfeature "ovsqlite-util script" dev-perl/DBD-SQLite
	fi

	tmpfiles_process inn.conf
}
