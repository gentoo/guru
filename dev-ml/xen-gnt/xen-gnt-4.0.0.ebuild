# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml bindings to the Xen grant tables libraries"
HOMEPAGE="https://github.com/mirage/ocaml-gnt"
SRC_URI="https://github.com/mirage/ocaml-gnt/releases/download/v${PV}/${PN}-v${PV}.tbz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/cstruct
	dev-ml/cmdliner
	<=dev-ml/io-page-2.2.0
	dev-ml/lwt
	dev-ml/lwt-dllist
	dev-ml/mirage-profile
"
RDEPEND="${DEPEND}"

src_install() {
	dune_src_install xen-gnt
	dune_src_install xen-gnt-unix
}
