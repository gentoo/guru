# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="Constant time equal function to avoid timing attacks in OCaml"
HOMEPAGE="
	https://github.com/mirage/eqaf
	https://opam.ocaml.org/packages/eqaf/
"
SRC_URI="https://github.com/mirage/eqaf/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	>=dev-lang/ocaml-4.07.0:=[ocamlopt?]
	>=dev-ml/cstruct-1.1.0:=
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/ocaml-base64
		dev-ml/alcotest
		dev-ml/crowbar
	)
"

RESTRICT="!test? ( test )"
