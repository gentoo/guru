# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="RFC 1035 Internet domain names"
HOMEPAGE="https://github.com/hannesm/domain-name"
SRC_URI="https://github.com/hannesm/domain-name/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

DEPEND="
	test? ( dev-ml/alcotest )
"
