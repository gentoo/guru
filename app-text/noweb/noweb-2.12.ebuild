# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils toolchain-funcs elisp-common

MYPV="$(ver_rs 1 _)"

DESCRIPTION="a literate programming tool, lighter than web"
HOMEPAGE="https://www.cs.tufts.edu/~nr/noweb/"
SRC_URI="https://github.com/nrnrnr/${PN}/archive/v${MYPV}.tar.gz -> ${P}.tar.gz"

LICENSE="
	|| ( BSD-2 noweb )
	emacs? ( GPL-2 )
"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~ppc-macos ~x64-macos ~x86-macos"
IUSE="emacs examples"

DEPEND="
	dev-lang/icon
	sys-apps/debianutils
	virtual/tex-base

	emacs? ( app-editors/emacs:= )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MYPV}"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	# glibc2.10 compat (bug 270757)
#	mkdir d && cp -r c/* d/
	sed "s/getline (/getline_nonlibc (/" -i src/c/getline.{c,h} || die
	sed "s/getline(/getline_nonlibc(/" -i src/c/{notangle.c,getline.c,finduses.c} || die
#	diff -u d/ c/

	# dont run texhash...
	sed -i -e "s/texhash/true/" src/Makefile || die
	# dont strip...
	sed -i -e "s/strip/true/" src/Makefile || die

	sed -i -e "s/CC=gcc -ansi -pedantic -O -Wall -Werror//" src/Makefile || die
	sed -i -e "s/CFLAGS=//" src/Makefile || die
	sed -i -e "s/CC=gcc -ansi -pedantic -O -Wall -Werror//" src/c/Makefile || die
	sed -i -e "s/CFLAGS=//" src/c/Makefile || die

	eapply "${FILESDIR}/${P}-recmake.patch"

	sed -i -e "s/CC = cc//" contrib/norman/numarkup/Makefile || die
	sed -i -e "s/CFLAGS = -O//" contrib/norman/numarkup/Makefile || die

	eapply "${FILESDIR}/${P}-ldflags.patch"
	eapply_user
}

src_compile() {
	# noweb tries to use notangle and noweb; see bug #50429
	cd "${S}/src/c"

	emake	ICONC="icont" \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LIBSRC="icon" || die

	export PATH="${PATH}:${T}"
	cd "${S}/src"

	emake	ICONC="icont" \
		CC="$(tc-getCC)" \
		BIN="${T}" \
		LIB="${T}" \
		LIBSRC="icon" \
		install-code || die "make temporal install failed."

	emake	ICONC="icont" \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LIBSRC="icon" || die "make failed"

	# Set awk to awk not nawk
	./awkname awk

	if use emacs; then
		elisp-compile elisp/noweb-mode.el || die "elisp-compile failed"
	fi
}

src_install () {
	cd "${S}/src"

	# It needs the directories to exist first...
	dodir /usr/bin
	dodir "/usr/libexec/${PN}"
	dodir /usr/share/man
	dodir /usr/share/texmf-site/tex/inputs

	emake	ICONC="icont" \
		BIN="${ED}/usr/bin" \
		LIBSRC="icon" \
		LIBNAME="${EPREFIX}/usr/libexec/${PN}" \
		LIB="${ED}/usr/libexec/${PN}" \
		MAN="${ED}/usr/share/man" \
		TEXNAME="${EPREFIX}/usr/share/texmf-site/tex/inputs" \
		TEXINPUTS="${ED}/usr/share/texmf-site/tex/inputs" \
		install || die "make install failed"

	cd "${S}"

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins -r examples/.
	fi

	if use emacs; then
		elisp-install "${PN}" "${S}"/src/elisp/noweb-mode.{el,elc} \
			|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
			|| die "elisp-site-file-install failed"
	fi
	einstalldocs
}

pkg_postinst() {
	use emacs && elisp-site-regen
	einfo "Running texhash to complete installation.."
	texhash
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
