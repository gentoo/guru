# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="13e5b90eecc79ec6704efb333c4c100187520e80"

inherit autotools elisp-common java-pkg-opt-2 toolchain-funcs

DESCRIPTION="The Aldor Programming Language"
HOMEPAGE="http://pippijn.github.io/aldor"
SRC_URI="
	https://github.com/pippijn/aldor/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	doc? (
		http://aldor.org/docs/libaldor.pdf.gz
		https://github.com/pippijn/aldor/files/5469932/algebra.pdf
	)
	emacs? ( http://hemmecke.de/aldor/aldor.el.nw )
"
S="${WORKDIR}/${PN}-${COMMIT}/aldor"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc emacs java"

PATCHES=(
	"${FILESDIR}/${PN}-respect-cflags.patch"
	"${FILESDIR}/${PN}-respect-ar.patch"
)

#is junit dep. only for test?
#TODO: choose a slot for junit
CDEPEND="
	dev-libs/boehm-gc

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

DOCS=( AUTHORS README.building README.binary-only README.library ../README.md )

src_unpack() {
	unpack "${P}.tar.gz"
	if use doc; then
		cp "${DISTDIR}/libaldor.pdf.gz" "${S}" || die
		gunzip "${S}/libaldor.pdf.gz" || die
	fi
	if use emacs; then
		cp "${DISTDIR}/aldor.el.nw" "${S}" || die
	fi
}

src_prepare() {
	tc-export CC
	#should be conditional with boehm-gc
	sed -e 's|-L /usr/X11/lib|-L /usr/X11/lib -lgc|g' -i aldor/src/aldor.conf || die
	#fix hardcoded cc
	sed -e "s|cc-name\", \"cc\"|cc-name\", \"${CC}\"|g" -i aldor/subcmd/unitools/unicl.c || die

	default
	eautoreconf
}

src_configure() {
	#install headers in a subfolder to avoid collisions with another packages
	#force boehm-gc for now, without it won't build ...
	local myconf=(
		--disable-static
		--enable-libraries
		--enable-shared
		--includedir="${EPREFIX}/usr/include/aldor"
		--prefix="${EPREFIX}/usr"
		--with-boehm-gc

		$(use_enable java)
		$(use_with java java-junit)
	)
	econf "${myconf[@]}"
}

src_compile() {
	if use doc; then
		pushd "${S}/aldorug" || die
		emake aldorug.pdf || die "make aldorug.pdf failed"
		popd || die

		pushd "${S}/lib/aldor/tutorial" || die
		pdflatex tutorial.tex || die "make tutorial.pdf failed"
		popd || die
	fi
	if use emacs; then
		notangle "aldor.el.nw" > aldor.el || die
		notangle -Rinit.el "aldor.el.nw" | sed -e '1s/^.*$/;; aldor mode/' > 64aldor-gentoo.el || die
		if use doc; then
			einfo "Documentation for the aldor emacs mode"
			noweave "aldor.el.nw" > aldor-mode.tex || die
			pdflatex aldor-mode.tex || die "make aldor-mode.pdf failed"
		fi
	fi
	default
}

src_install() {
	use doc && DOCS+=( aldorug/aldorug.pdf lib/aldor/tutorial/tutorial.pdf libaldor.pdf "${DISTDIR}/algebra.pdf" )

	if use emacs; then
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
