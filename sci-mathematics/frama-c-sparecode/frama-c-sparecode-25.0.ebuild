# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib toolchain-funcs

DESCRIPTION="Spare code plugin for frama-c"
HOMEPAGE="https://frama-c.com"
NAME="Manganese"
SRC_URI="https://frama-c.com/download/frama-c-${PV}-${NAME}.tar.gz"

S="${WORKDIR}/frama-c-${PV}-${NAME}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
RESTRICT="strip"

RDEPEND="~sci-mathematics/frama-c-${PV}:=[ocamlopt?]
		~sci-mathematics/frama-c-pdg-${PV}:=[ocamlopt?]
		~sci-mathematics/frama-c-eva-${PV}:=[ocamlopt?]
		~sci-mathematics/frama-c-inout-${PV}:=[ocamlopt?]
		~sci-mathematics/frama-c-users-${PV}:=[ocamlopt?]"
DEPEND="${RDEPEND}"

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
		--disable-gui \
		--enable-sparecode \
		--enable-users \
		--enable-callgraph \
		--enable-eva \
		--enable-server \
		--enable-pdg \
		--enable-postdominators \
		--enable-from-analysis
	printf 'include share/Makefile.config\n' > src/plugins/sparecode/Makefile || die
	sed -e '/^# *Sparecode :/bl;d' -e ':l' -e '/^\$(eval/Q;n;bl' < Makefile >> src/plugins/sparecode/Makefile || die
	printf 'include share/Makefile.dynamic\n' >> src/plugins/sparecode/Makefile || die
	export FRAMAC_SHARE="${ESYSROOT}/usr/share/frama-c"
	export FRAMAC_LIBDIR="${EPREFIX}/usr/$(get_libdir)/frama-c"
}

src_compile() {
	emake -f src/plugins/sparecode/Makefile FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}"
}

src_install() {
	emake -f src/plugins/sparecode/Makefile FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" DESTDIR="${ED}" install
}
