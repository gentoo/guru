# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Password based key derivation functions (PBKDF) from PKCS#5"
HOMEPAGE="https://github.com/abeaumont/ocaml-pbkdf"
SRC_URI="https://github.com/abeaumont/ocaml-${PN}/releases/download/${PV}/${P}.tbz"

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
