# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYPN="ocaml-${PN}"

DESCRIPTION="Library for finding the CRC of parts of various kinds of data in-place"
HOMEPAGE="
	https://github.com/xapi-project/ocaml-crc
	https://opam.ocaml.org/packages/crc/
"
SRC_URI="https://github.com/xapi-project/${MYPN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

DEPEND="
	dev-ml/cstruct:=
	dev-ml/rpc:=
	dev-ml/ppx_sexp_conv:=
"
RDEPEND="
	${DEPEND}
	test? ( dev-ml/ounit2 )
"

RESTRICT="!test? ( test )"
PATCHES="${FILESDIR}/${P}-ounit2.patch"
