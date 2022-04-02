# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune findlib

DESCRIPTION="A compiler from OCaml bytecode to javascript"
HOMEPAGE="
	http://ocsigen.org/js_of_ocaml/
	https://github.com/ocsigen/js_of_ocaml
"
SRC_URI="https://github.com/ocsigen/js_of_ocaml/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/cmdliner
	dev-ml/lwt
	dev-ml/menhir
	dev-ml/ppxlib
	dev-ml/ppx_expect
	dev-ml/react
	dev-ml/reactiveData
	dev-ml/tyxml
	dev-ml/yojson
"
DEPEND="${RDEPEND}"

src_install() {
	for p in js_of_ocaml{,-compiler,-lwt,-ppx,-ppx_deriving_json,-toplevel,-tyxml} ; do
		dune_src_install ${p}
	done
}
