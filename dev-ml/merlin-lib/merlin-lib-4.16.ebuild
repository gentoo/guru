# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Merlin's libraries"
HOMEPAGE="
	https://opam.ocaml.org/packages/merlin-lib/
	https://github.com/ocaml/merlin/
"
SRC_URI="https://github.com/ocaml/merlin/archive/v${PV}-414.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/merlin-${PV}-414"

LICENSE="MIT"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt"

# Tests require `menhir-20201216` which is not in the Gentoo repository,
# though the opam file says more recent versions are supported.
RESTRICT="test"

RDEPEND="
	=dev-lang/ocaml-4.14*:=
	>=dev-ml/dune-2.9.0:=
	>=dev-ml/csexp-1.5.1:=
"

DEPEND="
	${RDEPEND}
"

src_compile() {
	dune-compile merlin-lib
}
