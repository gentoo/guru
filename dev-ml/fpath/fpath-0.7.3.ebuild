# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit findlib opam

DESCRIPTION="File paths for OCaml"
HOMEPAGE="
	https://erratique.ch/software/fpath
	https://github.com/dbuenzli/fpath
"
SRC_URI="https://github.com/dbuenzli/fpath/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-ml/topkg"
BDEPEND="dev-ml/ocamlbuild"

RESTRICT="!test? ( test )"

src_compile() {
	ocaml pkg/pkg.ml build --tests $(usex test 'true' 'false') || die
}

src_test() {
	ocaml pkg/pkg.ml test || die
}
