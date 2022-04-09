# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Unix implementation of the Mirage_types.BLOCK interface"
HOMEPAGE="https://github.com/mirage/mirage-block-unix"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/cstruct[lwt]
	dev-ml/lwt
	dev-ml/mirage-block
	dev-ml/rresult
	dev-ml/uri
	dev-ml/logs
	dev-ml/io-page

"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/fmt
		>=dev-ml/ounit-2
		dev-ml/diet
	)
"

RESTRICT="!test? ( test )"
