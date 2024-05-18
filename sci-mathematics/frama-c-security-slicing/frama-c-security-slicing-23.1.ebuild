# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools findlib toolchain-funcs

DESCRIPTION="Security slicing plugin for frama-c"
HOMEPAGE="https://frama-c.com"
NAME="Vanadium"
SRC_URI="https://frama-c.com/download/frama-c-${PV}-${NAME}.tar.gz"

S="${WORKDIR}/frama-c-${PV}-${NAME}/src/plugins/security_slicing"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
RESTRICT="strip"

RDEPEND="~sci-mathematics/frama-c-${PV}:=[gtk,ocamlopt?]
		~sci-mathematics/frama-c-eva-${PV}:=[gtk,ocamlopt?]
		~sci-mathematics/frama-c-pdg-${PV}:=[ocamlopt?]
		~sci-mathematics/frama-c-slicing-${PV}:=[gtk,ocamlopt?]"
DEPEND="${RDEPEND}"

src_prepare() {
	export FRAMAC_SHARE="${ESYSROOT}/usr/share/frama-c"
	export FRAMAC_LIBDIR="${EPREFIX}/usr/$(get_libdir)/frama-c"
	eautoconf
	eapply_user
}

src_configure() {
	econf --enable-security-slicing
}

src_compile() {
	tc-export AR
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}"
}

src_install() {
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" DESTDIR="${ED}" install
}
