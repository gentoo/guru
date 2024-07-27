# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Parse ocaml compiler output into structured form"
HOMEPAGE="
	https://opam.ocaml.org/packages/ocamlc-loc/
	https://github.com/ocaml/dune
"
SRC_URI="https://github.com/ocaml/dune/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/dune-${PV}"

LICENSE="MIT"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt"

RESTRICT="test"

RDEPEND="
	~dev-ml/dyn-${PV}:=
"

DEPEND="
	${RDEPEND}
"

src_configure() {
	:
}

src_compile() {
	dune-compile ocamlc-loc
}

src_install() {
	dune-install ocamlc-loc
}
