# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Map OCaml arrays onto C-like structs"
HOMEPAGE="https://github.com/mirage/ocaml-cstruct"
SRC_URI="https://github.com/mirage/ocaml-cstruct/archive/v${PV}.tar.gz -> ocaml-ctruct-${PV}.tar.gz"
S="${WORKDIR}/ocaml-cstruct-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	>=dev-lang/ocaml-4.08.0
	>=dev-ml/fmt-0.8.9
	dev-ml/async
	dev-ml/async_unix
	dev-ml/core
	dev-ml/lwt
	dev-ml/sexplib
	dev-ml/ppxlib
"
DEPEND="${RDEPEND}"

src_install() {
	dune_src_install cstruct-async
	dune_src_install cstruct-lwt
	dune_src_install cstruct-sexp
	dune_src_install cstruct-unix
	dune_src_install cstruct
	dune_src_install ppx_cstruct
}
