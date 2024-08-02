# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="LSP protocol implementation in OCaml"
HOMEPAGE="
	https://opam.ocaml.org/packages/lsp/
	https://github.com/ocaml/ocaml-lsp/
"
SRC_URI="https://github.com/ocaml/ocaml-lsp/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocaml-lsp-${PV}"

LICENSE="ISC"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt"

RESTRICT="test"

RDEPEND="
	>=dev-lang/ocaml-4.14:=
	~dev-ml/jsonrpc-${PV}:=
	dev-ml/yojson:=
	>=dev-ml/ppx_yojson_conv_lib-0.14:=
	>=dev-ml/uutf-1.0.2:=
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	>=dev-ml/dune-3.0:=
"

src_compile() {
	dune-compile lsp
}
