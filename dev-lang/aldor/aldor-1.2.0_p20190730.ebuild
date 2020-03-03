# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="13e5b90eecc79ec6704efb333c4c100187520e80"
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools elisp-common

DESCRIPTION="The Aldor Programming Language"
HOMEPAGE="http://pippijn.github.io/aldor"
SRC_URI="	https://github.com/pippijn/aldor/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
		doc? ( http://aldor.org/docs/libaldor.pdf.gz )
		emacs? ( http://hemmecke.de/aldor/aldor.el.nw )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc emacs"

RDEPEND="
	emacs? ( app-editors/emacs:= )
"
DEPEND="
	${RDEPEND}
	virtual/yacc

	doc? ( virtual/latex-base )
	emacs? ( app-text/noweb )
"

DOCS=( AUTHORS COPYRIGHT LICENSE )

S="${WORKDIR}/${P}/aldor"

src_compile() {
	if use doc ; then
		( cd aldorug; emake aldorug.pdf ) || die "make aldorug.pdf failed"
		( cd lib/aldor/tutorial
			pdflatex tutorial.tex
			pdflatex tutorial.tex ) || die "make tutorial.pdf failed"
		cp "${DISTDIR}/libaldor.pdf.gz" .
		gunzip libaldor.pdf.gz
		tar xzf "${DISTDIR}/algebra.html.tar.gz"
	fi

	if use emacs ; then
		notangle "${DISTDIR}/aldor.el.nw" > aldor.el
		notangle -Rinit.el "${DISTDIR}/aldor.el.nw" | \
			sed -e '1s/^.*$/;; aldor mode/' > 64aldor-gentoo.el
		if use doc ; then
			einfo "Documentation for the aldor emacs mode"
			noweave "${DISTDIR}/aldor.el.nw" > aldor-mode.tex
			pdflatex aldor-mode.tex
			pdflatex aldor-mode.tex
		fi
	fi
	default
}

src_install() {
	if use doc ; then
		DOCS+=( aldorug/aldorug.pdf lib/aldor/tutorial/tutorial.pdf libaldor.pdf )
	fi
	if use emacs ; then
		DOCS+=( aldor-mode.pdf )
		elisp-site-file-install aldor.el
		elisp-site-file-install 64aldor-gentoo.el
	fi
	default

	# Add information about ALDORROOT to environmental variables
	cat > 99aldor <<- EOF
		ALDORROOT="${EPREFIX}/usr"
	EOF
	doenvd 99aldor
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_prerm() {
	[ -f "${SITELISP}/site-gentoo.el" ] && elisp-site-regen
}
