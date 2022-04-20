# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="IO memory page library for Mirage backends"
HOMEPAGE="
	https://github.com/mirage/io-page
	https://opam.ocaml.org/packages/io-page/
"
SRC_URI="https://github.com/mirage/io-page/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	>=dev-lang/ocaml-4.08.0:=[ocamlopt?]
	>=dev-ml/cstruct-2.0.0:=
"
DEPEND="
	${RDEPEND}
	test? ( dev-ml/ounit2 )
"
BDEPEND="virtual/pkgconfig"

RESTRICT="!test? ( test )"
PATCHES="${FILESDIR}/${PN}-2.4.0-ounit2.patch"
