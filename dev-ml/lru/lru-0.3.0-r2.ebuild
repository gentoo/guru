# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Scalable LRU caches for OCaml"
HOMEPAGE="https://github.com/pqwy/lru"
SRC_URI="https://github.com/pqwy/lru/releases/download/v${PV}/${PN}-v${PV}.tbz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="dev-ml/psq"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/alcotest
		dev-ml/qcheck
	)
"

RESTRICT="!test? ( test )"
