# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Jsonrpc protocol implementation"
HOMEPAGE="
	https://opam.ocaml.org/packages/jsonrpc/
	https://github.com/ocaml/ocaml-lsp
"
SRC_URI="https://github.com/ocaml/ocaml-lsp/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocaml-lsp-${PV}"

LICENSE="ISC"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt"

RESTRICT="test"

src_compile() {
	dune-compile jsonrpc
}
