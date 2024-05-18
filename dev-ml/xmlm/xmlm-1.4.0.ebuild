# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib opam

DESCRIPTION="Ocaml XML manipulation module"
HOMEPAGE="
	https://erratique.ch/software/xmlm
	https://github.com/dbuenzli/xmlm
"
SRC_URI="https://erratique.ch/software/${PN}/releases/${P}.tbz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-ml/topkg"
BDEPEND="dev-ml/ocamlbuild"

RESTRICT="!test? ( test )"
OPAM_FILE=opam

src_compile() {
	ocaml pkg/pkg.ml build --tests $(usex test 'true' 'false') || die
}

src_test() {
	opam_src_test
	ocaml pkg/pkg.ml test || die
}
