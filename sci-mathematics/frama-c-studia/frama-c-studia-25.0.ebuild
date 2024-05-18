# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib toolchain-funcs

DESCRIPTION="Studia plugin for frama-c"
HOMEPAGE="https://frama-c.com"
NAME="Manganese"
SRC_URI="https://frama-c.com/download/frama-c-${PV}-${NAME}.tar.gz"

S="${WORKDIR}/frama-c-${PV}-${NAME}/src/plugins/studia"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk +ocamlopt"
RESTRICT="strip"

RDEPEND="~sci-mathematics/frama-c-${PV}:=[gtk=,ocamlopt?]
		~sci-mathematics/frama-c-eva-${PV}:=[gtk=,ocamlopt?]"
DEPEND="${RDEPEND}"

src_prepare() {
	export FRAMAC_SHARE="${ESYSROOT}/usr/share/frama-c"
	export FRAMAC_LIBDIR="${EPREFIX}/usr/$(get_libdir)/frama-c"
	export ENABLE_GUI="$(usex gtk yes no)"
	eautoconf
	eapply_user
}

src_configure() {
	export ENABLE_EVA=yes
	econf --enable-studia
}

src_compile() {
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" ENABLE_GUI="${ENABLE_GUI}"
}

src_install() {
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" ENABLE_GUI="${ENABLE_GUI}" DESTDIR="${ED}" install
}
