# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Parser combinators built for speed and memory efficiency"
HOMEPAGE="https://github.com/inhabitedtype/angstrom"
SRC_URI="https://github.com/inhabitedtype/angstrom/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="async lwt-unix ocamlopt unix"

RDEPEND="
	async? ( dev-ml/async )
	lwt-unix? (
		dev-ml/base
		dev-ml/lwt
	)
	unix? ( dev-ml/base )

	dev-ml/bigstringaf
"
DEPEND="${RDEPEND}"

src_compile() {
	local pkgs="angstrom"
	use async && pkgs="${pkgs},angstrom-async"
	use unix && pkgs="${pkgs},angstrom-unix"
	use lwt-unix && pkgs="${pkgs},angstrom-lwt-unix"
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install angstrom
	use async && dune_src_install angstrom-async
	use lwt-unix && dune_src_install angstrom-lwt-unix
	use unix && dune_src_install angstrom-unix
}
