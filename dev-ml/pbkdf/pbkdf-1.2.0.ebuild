# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYPN="ocaml-${PN}"

DESCRIPTION="Password based key derivation functions (PBKDF) from PKCS#5"
HOMEPAGE="
	https://github.com/abeaumont/ocaml-pbkdf
	https://opam.ocaml.org/packages/pbkdf/
"
SRC_URI="https://github.com/abeaumont/${MYPN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	>=dev-lang/ocaml-4.07.0:=[ocamlopt?]
	>=dev-ml/cstruct-6.0.0:=
	dev-ml/mirage-crypto
"
DEPEND="
	${RDEPEND}
	test? ( >=dev-ml/alcotest-0.8.1 )
"

RESTRICT="!test? ( test )"
