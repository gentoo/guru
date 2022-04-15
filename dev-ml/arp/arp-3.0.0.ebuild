# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="Address resolution protocol (ARP) implementation in OCaml"
HOMEPAGE="https://github.com/mirage/arp"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/cstruct:=
	dev-ml/ipaddr:=
	dev-ml/logs:=
	dev-ml/mirage-time:=
	dev-ml/lwt:=
	dev-ml/duration:=
	dev-ml/mirage-profile:=
	dev-ml/ethernet:=
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/mirage-random
		dev-ml/mirage-random-test
		dev-ml/alcotest
		dev-ml/fmt
		dev-ml/mirage-vnetif
		dev-ml/mirage-clock
		dev-ml/mirage-clock-unix
		dev-ml/mirage-time[unix]
		dev-ml/mirage-flow
	)
"

RESTRICT="!test? ( test )"
