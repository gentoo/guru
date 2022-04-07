# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune findlib multiprocessing

DESCRIPTION="A compiler from OCaml bytecode to javascript"
HOMEPAGE="
	http://ocsigen.org/js_of_ocaml/
	https://github.com/ocsigen/js_of_ocaml
"
SRC_URI="https://github.com/ocsigen/js_of_ocaml/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
IUSE="lwt ocamlopt ppx ppx-deriving-json test toplevel tyxml"

RDEPEND="
	dev-ml/cmdliner
	dev-ml/menhir
	dev-ml/ppxlib
	dev-ml/yojson

	lwt? ( dev-ml/lwt )
	tyxml? (
		dev-ml/react
		dev-ml/reactiveData
		dev-ml/tyxml
	)
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/re
		dev-ml/ppx_expect
		dev-ml/num
		dev-ml/ppxlib
		dev-ml/graphics
		dev-ml/cohttp[lwt-unix]
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	lwt? ( ppx )
	test? ( lwt ppx ppx-deriving-json toplevel tyxml )
	toplevel? ( ppx )
	tyxml? ( ppx )
"

src_compile() {
	local pkgs="js_of_ocaml,js_of_ocaml-compiler"
	for u in lwt ppx ppx-deriving-json toplevel tyxml ; do
		if use ${u} ; then
			pkgs="${pkgs},js_of_ocaml-${u//-/_}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install js_of_ocaml-compiler
	dune_src_install js_of_ocaml
	for u in lwt ppx ppx-deriving-json toplevel tyxml ; do
		if use ${u}; then
			dune_src_install "js_of_ocaml-${u//-/_}"
		fi
	done
}
