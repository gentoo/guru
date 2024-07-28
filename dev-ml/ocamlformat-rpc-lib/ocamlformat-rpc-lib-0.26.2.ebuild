# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Auto-formatter for OCaml code (RPC mode)"
HOMEPAGE="
	https://opam.ocaml.org/packages/ocamlformat-rpc-lib
	https://github.com/ocaml-ppx/ocamlformat
"
SRC_URI="https://github.com/ocaml-ppx/ocamlformat/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocamlformat-${PV}"

LICENSE="MIT"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-ml/csexp-1.4.0:=
"

DEPEND="
	${RDEPEND}
"

src_compile() {
	dune-compile ocamlformat-rpc-lib
}

src_install() {
	dune-install ocamlformat-rpc-lib
}
