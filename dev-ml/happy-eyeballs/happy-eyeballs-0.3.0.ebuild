# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="An implementation of happy eyeballs (RFC 8305) in OCaml with lwt"
HOMEPAGE="https://github.com/roburio/happy-eyeballs"
SRC_URI="https://github.com/roburio/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="lwt mirage ocamlopt"

RDEPEND="
	dev-ml/domain-name
	dev-ml/ipaddr
	dev-ml/logs
	dev-ml/fmt

	lwt? (
		dev-ml/cmdliner
		dev-ml/mtime
		dev-ml/lwt
		dev-ml/dns[client]
		dev-ml/duration
	)
	mirage? (
		dev-ml/mirage-clock
		dev-ml/dns[client]
		dev-ml/lwt
		dev-ml/tcpip
		dev-ml/mirage-random
		dev-ml/mirage-time
		dev-ml/duration
	)
"
DEPEND="${RDEPEND}"

src_compile() {
	local pkgs="happy-eyeballs"
	for u in lwt mirage ; do
		if use ${u} ; then
			pkgs="${pkgs},happy-eyeballs-${u}"
		fi
	done
	dune build --only-packages "${pkgs}" -j $(makeopts_jobs) --profile release || die
}

src_install() {
	dune_src_install happy-eyeballs
	for u in lwt mirage ; do
		if use ${u} ; then
			dune_src_install "happy-eyeballs-${u}"
		fi
	done
}
