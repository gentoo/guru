# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="Embed typed ASN.1 grammars in OCaml"
HOMEPAGE="
	https://github.com/mirleft/ocaml-asn1-combinators
	https://opam.ocaml.org/packages/asn1-combinators/
"
SRC_URI="https://github.com/mirleft/ocaml-${PN}/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	>=dev-lang/ocaml-4.08.0:=[ocamlopt?]
	>=dev-ml/cstruct-6.0.0:=
	dev-ml/ptime:=
	dev-ml/zarith:=
"
DEPEND="
	${RDEPEND}
	test? ( dev-ml/alcotest )
"

RESTRICT="!test? ( test )"
