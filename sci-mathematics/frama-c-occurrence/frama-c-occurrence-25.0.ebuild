# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib toolchain-funcs

DESCRIPTION="Occurrence analysis plugin for frama-c"
HOMEPAGE="https://frama-c.com"
NAME="Manganese"
SRC_URI="https://frama-c.com/download/frama-c-${PV}-${NAME}.tar.gz"

S="${WORKDIR}/frama-c-${PV}-${NAME}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk +ocamlopt"
RESTRICT="strip"

RDEPEND="~sci-mathematics/frama-c-${PV}:=[gtk=,ocamlopt?]
		~sci-mathematics/frama-c-eva-${PV}:=[gtk=,ocamlopt?]"
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
		$(use_enable gtk gui) \
		--enable-occurrence \
		--enable-eva \
		--enable-server
	printf 'include share/Makefile.config\n' > src/plugins/occurrence/Makefile || die
	sed -e '/^# *Occurrence/bl;d' -e ':l' -e '/^\$(eval/Q;n;bl' < Makefile >> src/plugins/occurrence/Makefile || die
	printf 'include share/Makefile.dynamic\n' >> src/plugins/occurrence/Makefile || die
	export FRAMAC_SHARE="${ESYSROOT}/usr/share/frama-c"
	export FRAMAC_LIBDIR="${EPREFIX}/usr/$(get_libdir)/frama-c"
}

src_compile() {
	emake -f src/plugins/occurrence/Makefile FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}"
}

src_install() {
	emake -f src/plugins/occurrence/Makefile FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" DESTDIR="${ED}" install
}