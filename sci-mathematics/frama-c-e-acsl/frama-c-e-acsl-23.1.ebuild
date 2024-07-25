# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib toolchain-funcs

DESCRIPTION="Runtime verification of ACSL (E-ACSL) plugin for frama-c"
HOMEPAGE="https://frama-c.com"
NAME="Vanadium"
SRC_URI="https://frama-c.com/download/frama-c-${PV}-${NAME}.tar.gz"

S="${WORKDIR}/frama-c-${PV}-${NAME}/src/plugins/e-acsl"

LICENSE="BSD LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
RESTRICT="strip"

RDEPEND="~sci-mathematics/frama-c-${PV}:=[ocamlopt?]
		~sci-mathematics/frama-c-rtegen-${PV}:=[ocamlopt?]"
DEPEND="${RDEPEND}"

src_prepare() {
	export FRAMAC_SHARE="${ESYSROOT}/usr/share/frama-c"
	export FRAMAC_LIBDIR="${EPREFIX}/usr/$(get_libdir)/frama-c"
	sed -i '/\$(CC)/s/-O2 -g3/$(CFLAGS)/' Makefile.in || die
	sed -i "s/ranlib/$(tc-getRANLIB)/" Makefile.in || die
	eautoconf
	eapply_user
}

src_configure() {
	econf --enable-e-acsl
}

src_compile() {
	tc-export AR
	export FRAMAC_ROOT_SRCDIR="${S}/../../.."
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}"
}

src_install() {
	export EACSL_INSTALL_LIB_DIR="${ED}/usr/$(get_libdir)/frama-c/e-acsl"
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" DESTDIR="${ED}" EACSL_INSTALL_LIB_DIR="${EACSL_INSTALL_LIB_DIR}" install
}
