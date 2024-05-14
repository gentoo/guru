# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib toolchain-funcs

DESCRIPTION="Plugin generating .mli interface files for plugin APIs for frama-c"
HOMEPAGE="https://frama-c.com"
NAME="Chromium"
SRC_URI="https://frama-c.com/download/frama-c-${PV}-${NAME}.tar.gz"

S="${WORKDIR}/frama-c-${PV}-${NAME}/src/plugins/print_api"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
RESTRICT="strip"

RDEPEND="~sci-mathematics/frama-c-${PV}:=[ocamlopt?]"
DEPEND="${RDEPEND}"

src_compile() {
	export FRAMAC_SHARE="${ESYSROOT}/usr/share/frama-c"
	export FRAMAC_LIBDIR="${EPREFIX}/usr/$(get_libdir)/frama-c"
	tc-export AR
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}"
}

src_install() {
	emake FRAMAC_SHARE="${FRAMAC_SHARE}" FRAMAC_LIBDIR="${FRAMAC_LIBDIR}" DESTDIR="${ED}" install
}
