# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_PN="ocaml-${PN}"

DESCRIPTION="Public Key Infrastructure purely in OCaml"
HOMEPAGE="
	https://github.com/mirleft/ocaml-x509
	https://opam.ocaml.org/packages/x509/
"
SRC_URI="https://github.com/mirleft/${MY_PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	>=dev-lang/ocaml-4.08.0:=[ocamlopt?]
	>=dev-ml/asn1-combinators-0.2.0:=
	>=dev-ml/cstruct-6.0.0:=
	>=dev-ml/domain-name-0.3.0:=
	>=dev-ml/fmt-0.8.7:=
	>=dev-ml/gmap-0.3.0:=
	>=dev-ml/ipaddr-5.2.0:=
	dev-ml/logs:=
	>=dev-ml/mirage-crypto-0.10.0:=[ec,pk,rng]
	>=dev-ml/ocaml-base64-3.3.0:=
	dev-ml/pbkdf:=
	dev-ml/ptime:=
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/alcotest
		>=dev-ml/cstruct-3.0.0[unix]
	)
"

RESTRICT="!test? ( test )"
