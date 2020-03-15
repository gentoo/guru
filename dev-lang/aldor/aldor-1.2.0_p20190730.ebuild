# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="13e5b90eecc79ec6704efb333c4c100187520e80"

#TODO: figure out if a java eclass is needed
inherit autotools elisp-common

DESCRIPTION="The Aldor Programming Language"
HOMEPAGE="http://pippijn.github.io/aldor"
SRC_URI="
	https://github.com/pippijn/aldor/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	doc? ( http://aldor.org/docs/libaldor.pdf.gz )
	emacs? ( http://hemmecke.de/aldor/aldor.el.nw )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

#force boehm-gc for now, without it won't build ...
IUSE="+boehm-gc doc emacs java"

PATCHES=( "${FILESDIR}/respect-flags.diff" )

#is junit dep. only for test?
#TODO: choose a slot for junit
CDEPEND="
	boehm-gc? ( dev-libs/boehm-gc )
	emacs? ( app-editors/emacs:= )
	java? ( dev-java/junit:= )
"
RDEPEND="
	${CDEPEND}
	java? ( virtual/jre:1.8 )
"
DEPEND="
	${CDEPEND}
	java? ( virtual/jdk:1.8 )
"
BDEPEND="
	virtual/yacc

	doc? ( virtual/latex-base )
	emacs? ( app-text/noweb )
"

S="${WORKDIR}/${PN}-${COMMIT}/aldor"

DOCS=( AUTHORS README.building README.binary-only README.library ../README.md )

src_unpack() {
	unpack "${P}.tar.gz"
	if use doc ; then
		cp "${DISTDIR}/libaldor.pdf.gz" "${S}"
		gunzip "${S}/libaldor.pdf.gz"
	fi
	use emacs && cp "${DISTDIR}/aldor.el.nw" "${S}"
}

src_prepare() {
	use boehm-gc && sed -i 's|-L /usr/X11/lib|-L /usr/X11/lib -lgc|' aldor/src/aldor.conf || die

	default
	eautoreconf
}

src_configure() {
	#install headers in a subfolder to avoid collisions with another packages
	local myconf=(
		--prefix="${EPREFIX}/usr"
		--includedir="${EPREFIX}/usr/include/aldor"
		--disable-static
		--enable-libraries
		--enable-shared
		$(use_enable java)
		$(use_with java java-junit)
		$(use_with boehm-gc)
	)
	econf "${myconf[@]}"
}

src_compile() {
	if use doc ; then
		cd "${S}/aldorug"
		emake aldorug.pdf || die "make aldorug.pdf failed"

		cd "${S}/lib/aldor/tutorial"
		pdflatex tutorial.tex || die "make tutorial.pdf failed"
	fi
	cd "${S}"
	if use emacs ; then
		notangle "aldor.el.nw" > aldor.el
		notangle -Rinit.el "aldor.el.nw" | sed -e '1s/^.*$/;; aldor mode/' > 64aldor-gentoo.el
		if use doc ; then
			einfo "Documentation for the aldor emacs mode"
			noweave "aldor.el.nw" > aldor-mode.tex
			pdflatex aldor-mode.tex || die "make aldor-mode.pdf failed"
		fi
	fi
	cd "${S}"
	default
}

src_install() {
	use doc && DOCS+=( aldorug/aldorug.pdf lib/aldor/tutorial/tutorial.pdf libaldor.pdf )

	if use emacs ; then
		use doc && DOCS+=( aldor-mode.pdf )
		#TODO: rename aldor.el
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
