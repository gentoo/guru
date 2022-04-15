# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Time signatures for MirageOS"
HOMEPAGE="https://github.com/mirage/mirage-time"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt unix"

RDEPEND="
	dev-ml/lwt
	unix? ( dev-ml/duration )
"
DEPEND="${RDEPEND}"

src_compile() {
	local pkgs="mirage-time"
	use unix && pkgs="${pkgs},mirage-time-unix"
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install mirage-time
	use unix && dune_src_install mirage-time-unix
}
