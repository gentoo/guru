# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune findlib multiprocessing

DESCRIPTION="Unit testing framework for OCaml"
HOMEPAGE="https://github.com/gildor478/ounit"
SRC_URI="https://github.com/gildor478/ounit/releases/download/v${PV}/${P}.tbz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="lwt ocamlopt"

RDEPEND="
	dev-ml/base-bytes:=
	dev-ml/base-unix:=
	dev-ml/seq:=
	dev-ml/stdlib-shims:=

	lwt? ( dev-ml/lwt:= )
"
DEPEND="${RDEPEND}"

src_compile() {
	local pkgs="ounit,ounit2"
	use lwt && pkgs="${pkgs},ounit-lwt,ounit2-lwt"
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	for p in ounit{,2} ; do
		dune_src_install "${p}"
	done
	if use lwt; then
		for p in ounit{,2}-lwt ; do
			dune_src_install "${p}"
		done
	fi
}
