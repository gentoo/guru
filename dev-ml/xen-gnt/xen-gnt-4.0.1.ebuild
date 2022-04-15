# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="OCaml bindings to the Xen grant tables libraries"
HOMEPAGE="https://github.com/mirage/ocaml-gnt"
SRC_URI="https://github.com/mirage/ocaml-gnt/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt unix"

DEPEND="
	>=dev-lang/ocaml-4.08.0:=[ocamlopt?]
	dev-ml/cstruct:=
	dev-ml/cmdliner:=
	>=dev-ml/io-page-2.4.0:=
	dev-ml/lwt:=
	dev-ml/lwt-dllist:=
	dev-ml/mirage-profile:=

	unix? ( app-emulation/xen )
"
RDEPEND="${DEPEND}"

src_compile() {
	local pkgs="xen-gnt"
	if use unix ; then
		pkgs="${pkgs},xen-gnt-unix"
	fi
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install xen-gnt
	use unix && dune_src_install xen-gnt-unix
}
