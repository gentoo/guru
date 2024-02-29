# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml binary heap implementation by Jean-Christophe Filliatre"
HOMEPAGE="https://github.com/backtracking/bheap"
SRC_URI="https://github.com/backtracking/${PN}/releases/download/${PV}/${P}.tbz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

DEPEND="
	test? ( dev-ml/stdlib-shims )
"

RESTRICT="!test? ( test )"
