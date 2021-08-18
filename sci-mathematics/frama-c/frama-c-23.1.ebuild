# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib toolchain-funcs

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="https://frama-c.com"
NAME="Vanadium"
SRC_URI="https://frama-c.com/download/${P}-${NAME}.tar.gz"

LICENSE="BSD LGPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+aorai +callgraph +dive +e-acsl +eva +from-analysis gtk +impact +inout +instantiate +loop-analysis +metrics +nonterm +obfuscator +ocamlopt +occurrence +pdg +postdominators +print-api +qed +report +rtegen +scope security-slicing +semantic-constant-folding +server +slicing +sparecode +studia +users +variadic +wp"
RESTRICT="strip"

# TODO: $(use_enable markdown-report mdr) -> missing dev-ml/ppx_deriving_yojson

RDEPEND="
	>=dev-lang/ocaml-4.08.1[ocamlopt?]
	>=dev-ml/ocamlgraph-1.8.5[gtk(-)?,ocamlopt?]
	>=dev-ml/zarith-1.5[ocamlopt?]
	>=dev-ml/yojson-1.4.1[ocamlopt?]
	gtk? ( >=dev-ml/lablgtk-2.14:2=[sourceview,gnomecanvas,ocamlopt?] )
	wp? ( >=sci-mathematics/why3-1.4.0 )"
DEPEND="${RDEPEND}
	media-gfx/graphviz"

REQUIRED_USE="
	dive? ( eva studia server )
	e-acsl? ( rtegen )
	eva? ( callgraph server )
	from-analysis? ( eva callgraph )
	impact? ( pdg eva inout slicing )
	inout? ( from-analysis eva callgraph )
	metrics? ( eva )
	nonterm? ( eva )
	occurrence? ( eva )
	pdg? ( from-analysis eva callgraph )
	scope? ( postdominators eva from-analysis pdg )
	security-slicing? ( slicing eva pdg gtk )
	semantic-constant-folding? ( eva )
	slicing? ( from-analysis pdg eva callgraph sparecode )
	sparecode? ( pdg eva users )
	studia? ( eva server )
	users? ( eva )
	wp? ( qed rtegen )"

S="${WORKDIR}/${P}-${NAME}"

src_prepare() {
	mv configure.in configure.ac || die
	sed -i 's/configure\.in/configure.ac/g' Makefile.generating Makefile || die
	sed -i '/\$(CC)/s/-O2 -g3/$(CFLAGS)/' src/plugins/e-acsl/Makefile.in || die
	sed -i "s/ranlib/$(tc-getRANLIB)/" src/plugins/e-acsl/Makefile.in || die
	touch config_file || die
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		--disable-landmarks \
		$(use_enable aorai) \
		$(use_enable callgraph) \
		$(use_enable dive) \
		$(use_enable e-acsl) \
		$(use_enable eva) \
		$(use_enable from-analysis) \
		$(use_enable gtk gui) \
		$(use_enable impact) \
		$(use_enable inout) \
		$(use_enable instantiate) \
		$(use_enable loop-analysis) \
		--disable-mdr \
		$(use_enable metrics) \
		$(use_enable nonterm) \
		$(use_enable obfuscator) \
		$(use_enable occurrence) \
		$(use_enable pdg) \
		$(use_enable postdominators) \
		$(use_enable print-api) \
		$(use_enable qed) \
		$(use_enable report) \
		$(use_enable rtegen) \
		$(use_enable scope) \
		$(use_enable security-slicing) \
		$(use_enable semantic-constant-folding) \
		$(use_enable server) \
		--disable-server-zmq \
		$(use_enable slicing) \
		$(use_enable sparecode) \
		$(use_enable studia) \
		$(use_enable users) \
		$(use_enable variadic) \
		$(use_enable wp) \
		--disable-wp-coq
}

src_compile() {
	tc-export AR
	default
}
