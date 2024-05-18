# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Functional Priority Search Queues for OCaml"
HOMEPAGE="https://github.com/pqwy/psq"
SRC_URI="https://github.com/pqwy/psq/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="dev-ml/seq:="
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/qcheck:*
		dev-ml/alcotest:*
	)
"

RESTRICT="!test? ( test )"
