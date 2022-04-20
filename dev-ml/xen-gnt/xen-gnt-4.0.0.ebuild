# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="${PN}-v${PV}"

inherit dune multiprocessing

DESCRIPTION="OCaml bindings to the Xen grant tables libraries"
HOMEPAGE="
	https://github.com/mirage/ocaml-gnt
	https://opam.ocaml.org/packages/xen-gnt/
"
SRC_URI="https://github.com/mirage/ocaml-gnt/releases/download/v${PV}/${MYP}.tbz"
S="${WORKDIR}/${MYP}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test unix"

DEPEND="
	>=dev-ml/cstruct-1.0.1:=
	dev-ml/cmdliner:=
	>=dev-ml/io-page-2.0.0:=[unix(-)?]
	dev-ml/lwt:=
	dev-ml/lwt-dllist:=
	>=dev-ml/mirage-profile-0.3:=

	unix? ( app-emulation/xen )
"
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( unix )"

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
