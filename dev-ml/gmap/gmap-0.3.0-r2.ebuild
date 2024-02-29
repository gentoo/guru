# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Heterogenous Map over a GADT"
HOMEPAGE="
	https://github.com/hannesm/gmap
	https://opam.ocaml.org/packages/gmap/
"
SRC_URI="https://github.com/hannesm/gmap/releases/download/${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

DEPEND="
	test? (
		dev-ml/alcotest
		dev-ml/fmt
	)
"

RESTRICT="!test? ( test )"
