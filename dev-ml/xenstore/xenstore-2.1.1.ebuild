# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A Xenstore protocol implementation in pure OCaml"
HOMEPAGE="
	https://github.com/mirage/ocaml-xenstore
	https://opam.ocaml.org/packages/xenstore/xenstore.2.0.0/
"
SRC_URI="https://github.com/mirage/ocaml-${PN}/releases/download/${PV}/${P}.tbz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/cstruct:=
	dev-ml/lwt:=
"
DEPEND="
	${RDEPEND}
	test? ( dev-ml/ounit2 )
"

RESTRICT="!test? ( test )"
PATCHES="${FILESDIR}/${P}-ounit2.patch"
