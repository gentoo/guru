# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib toolchain-funcs

DESCRIPTION="Aorai (automaton annotations) plugin for frama-c"
HOMEPAGE="https://frama-c.com"
NAME="Chromium"
SRC_URI="https://frama-c.com/download/frama-c-${PV}-${NAME}.tar.gz"

S="${WORKDIR}/frama-c-${PV}-${NAME}/src/plugins/aorai"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="eva +ocamlopt"
RESTRICT="strip"

RDEPEND="~sci-mathematics/frama-c-${PV}:=[ocamlopt?]
		eva? ( ~sci-mathematics/frama-c-eva-${PV}:=[ocamlopt?] )"
DEPEND="${RDEPEND}"

src_prepare() {
	export FRAMAC_SHARE="${ESYSROOT}/usr/share/frama-c"
	export FRAMAC_LIBDIR="${EPREFIX}/usr/$(get_libdir)/frama-c"
	export ENABLE_EVA="$(usex eva yes no)"
	sed -i '/aorai_eva_analysis.ml:/s, share/Makefile.config,,' Makefile.in || die
	eautoconf
	eapply_user
}

src_configure() {
	econf --enable-aorai
}

src_compile() {
	tc-export AR
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" ENABLE_EVA="${ENABLE_EVA}"
}

src_install() {
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" ENABLE_EVA="${ENABLE_EVA}" DESTDIR="${ED}" install
}
