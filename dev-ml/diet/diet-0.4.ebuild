# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYPN="ocaml-${PN}"

DESCRIPTION="A simple implementation of Discrete Interval Encoding Trees"
HOMEPAGE="
	https://opam.ocaml.org/packages/diet/
	https://github.com/mirage/ocaml-diet
"
SRC_URI="https://github.com/mirage/${MYPN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="dev-ml/stdlib-shims:="
DEPEND="
	${RDEPEND}
	test? ( dev-ml/ounit2 )
"

PATCHES="${FILESDIR}/${P}-ounit2.patch"
RESTRICT="!test? ( test )"
