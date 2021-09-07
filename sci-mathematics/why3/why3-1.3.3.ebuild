# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib

DESCRIPTION="Platform for deductive program verification"
HOMEPAGE="http://why3.lri.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/38367/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="coq emacs gtk +ocamlopt re +zarith zip"

DEPEND=">=dev-lang/ocaml-4.05.0[ocamlopt?]
		>=dev-ml/menhir-20151112
		dev-ml/num
		coq? ( >=sci-mathematics/coq-8.6 )
		emacs? ( app-editors/emacs:* )
		gtk? ( dev-ml/lablgtk:*[sourceview,ocamlopt?] )
		re? ( dev-ml/re dev-ml/seq )
		zarith? ( dev-ml/zarith )
		zip? ( dev-ml/camlzip )"
RDEPEND="${DEPEND}"

# doc needs sphinxcontrib-bibtex which is currently not packaged
#		doc? (
#			dev-python/sphinx
#			dev-python/sphinxcontrib-bibtex
#			|| ( dev-texlive/texlive-latex dev-tex/latexmk dev-tex/rubber )
#		)

DOCS=( CHANGES.md README.md )

src_prepare() {
	mv doc/why.1 doc/why3.1 || die
	mv configure.in configure.ac || die
	sed -i 's/configure\.in/configure.ac/g' Makefile.in || die
	sed -e '/^lib\/why3[a-z]*\$(EXE):/{n;s/-Wall/$(CFLAGS) $(LDFLAGS)/}' \
		-e '/^%.o: %.c/{n;s/\$(CC).*-o/$(CC) $(CFLAGS) -o/}' \
		-i Makefile.in || die
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		--disable-hypothesis-selection \
		--disable-pvs-libs \
		--disable-isabelle-libs \
		--disable-frama-c \
		--disable-web-ide \
		--disable-doc \
		$(use_enable coq coq-libs) \
		$(use_enable emacs emacs-compilation) \
		$(use_enable gtk ide) \
		$(use_enable ocamlopt native-code) \
		$(use_enable re) \
		$(use_enable zarith) \
		$(use_enable zip)
}

src_compile() {
	emake
	emake plugins
	#use doc && emake doc
}

src_install(){
	findlib_src_preinst
	emake install install-lib DESTDIR="${ED}"

	doman doc/why3.1
	einstalldocs
	docompress -x /usr/share/doc/${PF}/examples
	dodoc -r examples
	#if use doc; then
	#	dodoc doc/latex/manual.pdf
	#	dodoc -r doc/html
	#fi
}
