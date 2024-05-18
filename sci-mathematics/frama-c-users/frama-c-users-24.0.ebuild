# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib toolchain-funcs

DESCRIPTION="Users plugin for frama-c"
HOMEPAGE="https://frama-c.com"
NAME="Chromium"
SRC_URI="https://frama-c.com/download/frama-c-${PV}-${NAME}.tar.gz"

S="${WORKDIR}/frama-c-${PV}-${NAME}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
RESTRICT="strip"

RDEPEND="~sci-mathematics/frama-c-${PV}:=[ocamlopt?]
		~sci-mathematics/frama-c-callgraph-${PV}:=[ocamlopt?]
		~sci-mathematics/frama-c-eva-${PV}:=[ocamlopt?]"
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
		--enable-users \
		--enable-callgraph \
		--enable-eva \
		--enable-server
	printf 'include share/Makefile.config\n' > src/plugins/users/Makefile || die
	sed -e '/^# *Users analysis/bl;d' -e ':l' -e '/^\$(eval/Q;n;bl' < Makefile >> src/plugins/users/Makefile || die
	printf 'include share/Makefile.dynamic\n' >> src/plugins/users/Makefile || die
	export FRAMAC_SHARE="${ESYSROOT}/usr/share/frama-c"
	export FRAMAC_LIBDIR="${EPREFIX}/usr/$(get_libdir)/frama-c"
}

src_compile() {
	tc-export AR
	emake -f src/plugins/users/Makefile FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}"
}

src_install() {
	emake -f src/plugins/users/Makefile FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" DESTDIR="${ED}" install
}
