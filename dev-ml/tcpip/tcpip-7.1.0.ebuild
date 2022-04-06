# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYPN="mirage-${PN}"

DESCRIPTION="TCP/IP networking stack in pure OCaml, using the Mirage platform libraries"
HOMEPAGE="https://github.com/mirage/mirage-tcpip"
SRC_URI="https://github.com/mirage/${MYPN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/cstruct[lwt,ppx]
	dev-ml/mirage-net
	dev-ml/mirage-clock
	dev-ml/mirage-random
	dev-ml/mirage-time
	dev-ml/ipaddr[macaddr-cstruct]
	dev-ml/mirage-profile
	dev-ml/fmt
	dev-ml/lwt
	dev-ml/lwt-dllist
	dev-ml/logs
	dev-ml/duration
	dev-ml/randomconv
	dev-ml/ethernet
	dev-ml/arp
	dev-ml/mirage-flow
	dev-ml/lru
	dev-ml/metrics
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/mirage-vnetif
		dev-ml/alcotest
		dev-ml/pcap-format
		dev-ml/mirage-clock
		dev-ml/mirage-random-test
		dev-ml/ipaddr[cstruct]
	)
"
BDEPEND="virtual/pkgconfig"

RESTRICT="!test? ( test )"
