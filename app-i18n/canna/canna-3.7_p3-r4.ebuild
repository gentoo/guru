# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools cannadic edo systemd tmpfiles toolchain-funcs

MY_P="Canna${PV//[._]/}"
MYPV="${PV/_/}"

DESCRIPTION="A client-server based Kana-Kanji conversion system"
HOMEPAGE="http://canna.osdn.jp/"
SRC_URI="
	mirror://sourceforge.jp/${PN}/9565/${MY_P}.tar.bz2
	https://sources.debian.org/data/main/c/${PN}/${MYPV}-19/debian/patches/09_fix_manpages_error.patch
"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="canuum doc ipv6"

RDEPEND="
	acct-group/canna
	acct-user/canna
	canuum? (
		dev-libs/libspt
		sys-libs/ncurses:=
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	x11-misc/gccmakedep
	x11-misc/imake
	canuum? ( virtual/pkgconfig )
	doc? (
		app-text/ghostscript-gpl
		dev-texlive/texlive-langjapanese
		dev-texlive/texlive-latexrecommended
	)
"
PATCHES=(
	"${FILESDIR}/Canna-3.6-dont-grab-ctrl-o.patch"
	"${FILESDIR}/Canna-oldsock.patch"
	"${FILESDIR}/Canna-3.6-fix-warnings.patch"
	"${FILESDIR}/Canna-3.6-wconv.patch"
	"${FILESDIR}/Canna-3.7p1-fix-duplicated-strings.patch"
	"${FILESDIR}/Canna-3.7p1-notimeout.patch"
	"${FILESDIR}/Canna-3.7p3-fix-gcc4-warning.patch"
	"${FILESDIR}/Canna-3.7p3-redecl.patch"
	"${FILESDIR}/Canna-3.7p3-yenbs.patch"
	"${FILESDIR}/${PN}-gentoo.patch"
	"${FILESDIR}/${PN}-05_fix_spelling_error.patch"
	"${FILESDIR}/${PN}-06_fix_manpages_error.patch"
	"${FILESDIR}/${PN}-07_fix_ftbfs_on_hurd-i386.patch"
	"${FILESDIR}/${PN}-Wformat.patch"
	"${FILESDIR}/${PN}-Wformat-security.patch"
	"${DISTDIR}/09_fix_manpages_error.patch"
	"${FILESDIR}/${PN}-10_fix_configure.ac.patch"
	"${FILESDIR}/${PN}-11_fix_spelling_error_in_binary.patch"
	"${FILESDIR}/${PN}-12_make_the_output_of_mkbindic_reproducible.patch"
	"${FILESDIR}/${PN}-canuum.patch"
	"${FILESDIR}/${PN}-kpdef.patch"
	"${FILESDIR}/${PN}-overflow.patch"
	"${FILESDIR}/${PN}-posix-sort.patch"
	"${FILESDIR}/${PN}-respect-flags.patch"
	"${FILESDIR}/${PN}-rundir.patch"
)

src_prepare() {
	tc-export CC LD AR
	export CDEBUGFLAGS="${CFLAGS}"
	export LOCAL_LDFLAGS="${LDFLAGS}"
	export SHLIBGLOBALSFLAGS="${LDFLAGS}"
	export LOCAL_LDFLAGS="${LDFLAGS}"
	export CCOPTIONS="${CFLAGS} ${CPPFLAGS}"

	default

	sed \
		-e "/DefLibCannaDir/s:/lib$:/$(get_libdir):" \
		-e "/UseInet6/s:0:$(usex ipv6 1 0):" \
		-i ${PN^c}.conf \
		|| die

	eautoreconf
	rm -rf autom4te.cache || die
	if use canuum; then
		pushd canuum || die
		mv configure.{in,ac} || die
		eautoreconf
		rm -rf autom4te.cache || die
		popd || die
	fi
}

src_configure() {
	xmkmf -a || die

	if use canuum; then
		pushd canuum >/dev/null || die
		xmkmf -a || die
		# workaround for sys-libs/ncurses[tinfo]
		sed -i "/^TERMCAP_LIB/s:=.*:=$($(tc-getPKG_CONFIG) --libs ncurses):" Makefile || die
		popd >/dev/null || die
	fi
	if use doc; then
		pushd doc/man/guide/tex >/dev/null || die
		xmkmf -a || die
		popd >/dev/null || die
	fi
}

src_compile() {
	# bug #279706
	emake -j1 canna \
		CC="${CC}" \
		AR="${AR} -cq" \
		CDEBUGFLAGS="${CFLAGS}" \
		LOCAL_LDFLAGS="${LDFLAGS}" \
		SHLIBGLOBALSFLAGS="${LDFLAGS}" \
		CCOPTIONS="${CFLAGS} ${CPPFLAGS}"

	edo ${CC} ${CFLAGS} ${LDFLAGS} -fPIE "${FILESDIR}/cannaping.c" -o ./misc/cannaping -I./include -L./lib/canna -lcanna

	if use canuum; then
		einfo "Compiling canuum"
		emake -C canuum -j1 canuum \
			CC="${CC}" \
			AR="${AR} -cq" \
			CDEBUGFLAGS="${CFLAGS}" \
			LOCAL_LDFLAGS="${LDFLAGS}" \
			SHLIBGLOBALSFLAGS="${LDFLAGS}" \
			CCOPTIONS="${CFLAGS} ${CPPFLAGS}"
	fi

	if use doc; then
		# NOTE: build fails if infinality enabled in fontconfig
		einfo "Compiling DVI, PS, and PDF documents"
		# bug #223077
		export JLATEXCMD="platex -kanji=euc"
		export DVI2PSCMD="dvips"
		export VARTEXFONTS="${T}/fonts"
		emake -C doc/man/guide/tex -j1 canna.ps canna.pdf
	fi
}

src_install() {
	emake DESTDIR="${D}" install install.man
	einstalldocs
	dodoc *CHANGES* INSTALL* RKCCONF* WHATIS*

	if use canuum; then
		emake -C canuum DESTDIR="${D}" install install.man
		docinto canuum
		dodoc README.jp
	fi

	use doc && dodoc doc/man/guide/tex/canna.{dvi,ps,pdf}

	# for backward compatibility
	dosbin "${FILESDIR}/update-canna-dics_dir"

	dobin ./misc/cannaping
	exeinto /usr/libexec/canna
	doexe dic/ideo/pubdic/pod

	insinto /etc
	newins "${FILESDIR}/canna.hosts" hosts.canna

	insinto /etc/canna
	newins "${FILESDIR}/dot-canna" "default.canna"
	newins "${FILESDIR}/canna.hosts" "cannahosts"

	insinto /etc/canna/dics.dir.d
	newins "${ED}/var/lib/canna/dic/canna/dics.dir" 00canna.dics.dir
	rm -r "${ED}/var/lib/canna/dic/canna/dics.dir" || die

	keepdir /var/lib/canna/dic/{user,group}
	fowners canna:canna /var/lib/canna
	fperms 0775 /var/lib/canna/dic/{user,group}

	keepdir /var/log/canna
	fowners canna:canna /var/log/canna

	newconfd "${FILESDIR}/canna.confd" canna
	newinitd "${FILESDIR}/canna.initd" canna

	systemd_dounit "${FILESDIR}/canna.service"
	newtmpfiles "${FILESDIR}/canna-tmpfiles.conf" "canna.conf"

	find "${ED}" -type f -name "*.a" -delete || die
}

pkg_postinst() {
	tmpfiles_process canna.conf
	update-cannadic-dir

	if ! locale -a | grep -iq "ja_JP.eucjp"; then
		elog "Some dictionary tools in this package require ja_JP.EUC-JP locale."
		elog
		elog "# echo 'ja_JP.EUC-JP EUC-JP' >> ${EROOT}/etc/locale.gen"
		elog "# locale-gen"
		elog
	fi
}
