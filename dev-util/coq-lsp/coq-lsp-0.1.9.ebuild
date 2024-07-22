# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

COQ_V=8.19

DESCRIPTION="Visual Studio Code Extension and Language Server Protocol for Coq"
HOMEPAGE="https://github.com/ejgallego/coq-lsp"
SRC_URI="https://github.com/ejgallego/coq-lsp/archive/${PV}+${COQ_V}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}-${COQ_V}"

LICENSE="LGPL-2.1"

SLOT="0"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	=sci-mathematics/coq-${COQ_V}*:=
	sci-mathematics/coq-serapi:=

	dev-ml/cmdliner:=
	dev-ml/yojson:=
	dev-ml/uri:=
	dev-ml/dune-build-info:=

	dev-ml/menhir:=

	dev-ml/ppx_inline_test:=
"

DEPEND="
	${RDEPEND}
"

BEPEND="
	test? (
		dev-ml/alcotest:=
	)
"
