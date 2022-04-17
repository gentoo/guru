# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

MY_PN="ocaml-${PN}"

DESCRIPTION="Pure OCaml implementation of the vchan shared-memory communication protocol"
HOMEPAGE="
	https://github.com/mirage/ocaml-vchan
	https://opam.ocaml.org/packages/vchan/
"
SRC_URI="https://github.com/mirage/${MY_PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test unix xen"

RDEPEND="
	dev-ml/lwt:=
	dev-ml/ppx_sexp_conv:=
	dev-ml/io-page:=
	dev-ml/mirage-flow:=
	dev-ml/xenstore:=
	dev-ml/xenstore-clients:=
	dev-ml/sexplib:=
	dev-ml/cstruct:=[ppx]

	unix? (
		dev-ml/xen-evtchn:=[unix]
		dev-ml/xen-gnt:=[unix]
		dev-ml/fmt:=
	)
	xen? ( dev-ml/mirage-xen:= )
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/cmdliner
		dev-ml/ounit2
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( unix xen )"
PATCHES="${FILESDIR}/${P}-ounit2.patch"

src_compile() {
	local pkgs="vchan"
	for u in xen unix ; do
		if use ${u} ; then
			 pkgs="${pkgs},vchan-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install vchan
	use unix && dune_src_install vchan-unix
	use xen && dune_src_install vchan-xen
}
