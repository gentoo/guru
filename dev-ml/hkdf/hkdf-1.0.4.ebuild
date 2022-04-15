# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="HMAC-based Extract-and-Expand Key Derivation Function (RFC 5869)"
HOMEPAGE="https://github.com/hannesm/ocaml-hkdf"
SRC_URI="https://github.com/hannesm/ocaml-${PN}/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/cstruct
	dev-ml/mirage-crypto
"
DEPEND="
	${RDEPEND}
	test? ( dev-ml/alcotest )
"

RESTRICT="!test? ( test )"
