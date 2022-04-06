# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Infrastructure to collect metrics from OCaml applications"
HOMEPAGE="https://github.com/mirage/metrics"
SRC_URI="https://github.com/mirage/metrics/releases/download/${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="influx lwt ocamlopt rusage test unix"

RDEPEND="
	dev-ml/fmt
	influx? (
		dev-ml/duration
		dev-ml/lwt
	)
	lwt? (
		dev-ml/lwt
		dev-ml/logs
	)
	rusage? ( dev-ml/logs )
	unix? (
		dev-ml/uuidm
		dev-ml/mtime
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
	dune build --only-packages "${pkgs}" -j $(makeopts_jobs) --profile release || die
}

src_install() {
	dune_src_install metrics
	use influx && dune_src_install metrics-influx
	use lwt && dune_src_install metrics-lwt
	use rusage && dune_src_install metrics-rusage
	use unix && dune_src_install metrics-unix
}
