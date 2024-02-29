# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Extra string functions for OCaml"
HOMEPAGE="
	https://github.com/rgrinberg/stringext
	https://opam.ocaml.org/packages/stringext/
"
SRC_URI="https://github.com/rgrinberg/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

DEPEND="
	test? (
		dev-ml/ounit2
		dev-ml/qtest
	)
"

RESTRICT="!test? ( test )"
PATCHES="${FILESDIR}/${P}-ounit2.patch"
