# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Infrastructure to collect metrics from OCaml applications"
HOMEPAGE="
	https://github.com/mirage/metrics
	https://opam.ocaml.org/packages/metrics/
"
SRC_URI="https://github.com/mirage/metrics/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="influx lwt ocamlopt rusage test unix"

RDEPEND="
	>=dev-ml/fmt-0.8.7
	influx? (
		dev-ml/duration
		>=dev-ml/lwt-2.4.7
	)
	lwt? (
		>=dev-ml/lwt-2.4.7:=
		dev-ml/logs
	)
	rusage? ( dev-ml/logs )
	unix? (
		>=dev-ml/uuidm-0.9.6:=
		>=dev-ml/mtime-1.0.0:=
		>=dev-ml/lwt-2.4.7:=
		sci-visualization/gnuplot
	)
"
DEPEND="
	${RDEPEND}
	test? ( dev-ml/alcotest )
"

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( lwt unix )"

src_compile() {
	local pkgs="metrics"
	for u in influx lwt unix rusage ; do
		if use ${u} ; then
			pkgs="${pkgs},metrics-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install metrics
	use influx && dune_src_install metrics-influx
	use lwt && dune_src_install metrics-lwt
	use rusage && dune_src_install metrics-rusage
	use unix && dune_src_install metrics-unix
}
