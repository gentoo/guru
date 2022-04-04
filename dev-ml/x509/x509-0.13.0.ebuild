# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="Public Key Infrastructure purely in OCaml"
HOMEPAGE="https://github.com/mirleft/ocaml-x509"
SRC_URI="https://github.com/mirleft/ocaml-x509/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/asn1-combinators
	dev-ml/cstruct
	dev-ml/domain-name
	dev-ml/fmt
	dev-ml/gmap
	dev-ml/ipaddr
	dev-ml/logs
	dev-ml/mirage-crypto[ec,pk,rng]
	dev-ml/ocaml-base64
	dev-ml/pbkdf
	dev-ml/ptime
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/alcotest
		dev-ml/cstruct[unix]
	)
"

RESTRICT="!test? ( test )"
