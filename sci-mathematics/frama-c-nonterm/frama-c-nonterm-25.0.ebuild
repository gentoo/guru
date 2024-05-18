# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib toolchain-funcs

DESCRIPTION="Nonterm plugin for frama-c"
HOMEPAGE="https://frama-c.com"
NAME="Manganese"
SRC_URI="https://frama-c.com/download/frama-c-${PV}-${NAME}.tar.gz"

S="${WORKDIR}/frama-c-${PV}-${NAME}/src/plugins/nonterm"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
RESTRICT="strip"

RDEPEND="~sci-mathematics/frama-c-${PV}:=[ocamlopt?]
		~sci-mathematics/frama-c-eva-${PV}:=[ocamlopt?]"
DEPEND="${RDEPEND}"

src_prepare() {
	export FRAMAC_SHARE="${ESYSROOT}/usr/share/frama-c"
	export FRAMAC_LIBDIR="${EPREFIX}/usr/$(get_libdir)/frama-c"
	eautoconf
	eapply_user
}

src_configure() {
	export ENABLE_EVA=yes
	econf --enable-nonterm
}

src_compile() {
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}"
}

src_install() {
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" DESTDIR="${ED}" install
}
