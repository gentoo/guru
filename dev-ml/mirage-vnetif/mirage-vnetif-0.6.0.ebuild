# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Virtual network interface and software bridge for Mirage"
HOMEPAGE="https://github.com/mirage/mirage-vnetif"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt stack test"

RDEPEND="
	dev-ml/result
	dev-ml/lwt
	dev-ml/mirage-net
	dev-ml/cstruct
	dev-ml/ipaddr
	dev-ml/mirage-profile
	dev-ml/duration
	dev-ml/logs

	stack? (
		dev-ml/mirage-time
		dev-ml/mirage-clock
		dev-ml/mirage-random
		dev-ml/tcpip
		dev-ml/ethernet
		dev-ml/arp
	)
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/alcotest
		dev-ml/mirage-random-test
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( stack )"

src_compile() {
	local pkgs="mirage-vnetif"
	use stack && pkgs="${pkgs},mirage-vnetif-stack"
	dune build --only-packages "${pkgs}" -j $(makeopts_jobs) --profile release || die
}

src_install() {
	dune_src_install mirage-vnetif
	use stack && dune_src_install mirage-vnetif-stack
}
