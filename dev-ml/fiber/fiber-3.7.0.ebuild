# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Dune's monadic structured concurrency library"
HOMEPAGE="
	https://opam.ocaml.org/packages/fiber/
	https://github.com/ocaml-dune/fiber/
"
SRC_URI="https://github.com/ocaml-dune/fiber/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-ml/dune-3.6:=
	>=dev-lang/ocaml-4.08:=
	dev-ml/dyn:=
	dev-ml/stdune:=
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	<dev-ml/ppx_expect-0.17:=
"

src_compile() {
	dune-compile fiber
}
