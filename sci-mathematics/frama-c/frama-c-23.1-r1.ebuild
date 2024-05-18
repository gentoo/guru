# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="https://frama-c.com"
NAME="Vanadium"
SRC_URI="https://frama-c.com/download/${P}-${NAME}.tar.gz"

S="${WORKDIR}/${P}-${NAME}"

LICENSE="BSD LGPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk +ocamlopt"
RESTRICT="strip"

RDEPEND="
	>=dev-lang/ocaml-4.08.1[ocamlopt?]
	>=dev-ml/ocamlgraph-1.8.5[ocamlopt?]
	>=dev-ml/zarith-1.5[ocamlopt?]
	>=dev-ml/yojson-1.4.1[ocamlopt?]
	gtk? ( >=dev-ml/lablgtk-2.14:2=[sourceview,gnomecanvas,ocamlopt?] )"
DEPEND="${RDEPEND}
	media-gfx/graphviz"

src_prepare() {
	mv configure.in configure.ac || die
	sed -i 's/configure\.in/configure.ac/g' Makefile.generating Makefile || die
	touch config_file || die
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		--disable-landmarks \
		--with-no-plugin \
		$(use_enable gtk gui)
}

src_compile() {
	tc-export AR
	default
}

pkg_postinst() {
	elog "Starting with version 23.1, ${CATEGORY}/${PN} only installs"
	elog "the kernel, but no plugins. These are provided are separate"
	elog "packages that must be explicitely installed."
	elog "In particular, one may want to install:"
	elog "- ${CATEGORY}/${PN}-eva for value analysis"
	elog "- ${CATEGORY}/${PN}-wp for proving ACSL contracts"
	elog "- ${CATEGORY}/${PN}-e-acsl for runtime verification of ACSL contracts"
}
