# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Map OCaml arrays onto C-like structs"
HOMEPAGE="
	https://github.com/mirage/ocaml-cstruct
	https://opam.ocaml.org/packages/cstruct/
"
SRC_URI="https://github.com/mirage/ocaml-cstruct/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="async lwt ocamlopt ppx sexp test unix"

RDEPEND="
	>=dev-lang/ocaml-4.08.0:=[ocamlopt?]
	>=dev-ml/fmt-0.8.9:=

	async? (
		dev-ml/async:=
		dev-ml/async_unix:=
		dev-ml/core:=
	)
	lwt? ( dev-ml/lwt:= )
	ppx? (
		dev-ml/ppxlib:=
		dev-ml/stdlib-shims:=
	)
	sexp? ( dev-ml/sexplib:= )
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/alcotest
		dev-ml/crowbar
		dev-ml/ocaml-migrate-parsetree
		dev-ml/ppx_sexp_conv
		dev-ml/cppo
		dev-ml/lwt
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	ppx? ( sexp )
	test? ( sexp ppx )
"

src_compile() {
	local pkgs="cstruct"
	use ppx && pkgs="${pkgs},ppx_cstruct"
	for u in async lwt sexp unix ; do
		if use ${u} ; then
			pkgs="${pkgs},cstruct-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install cstruct
	use async && dune_src_install cstruct-async
	use lwt && dune_src_install cstruct-lwt
	use sexp && dune_src_install cstruct-sexp
	use unix && dune_src_install cstruct-unix
	use ppx && dune_src_install ppx_cstruct
}
