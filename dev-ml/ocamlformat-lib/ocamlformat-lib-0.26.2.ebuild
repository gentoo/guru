# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCamlFormat is a tool to automatically format OCaml code in a uniform style."
HOMEPAGE="
	https://opam.ocaml.org/packages/ocamlformat-lib
	https://github.com/ocaml-ppx/ocamlformat
"
SRC_URI="https://github.com/ocaml-ppx/ocamlformat/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocamlformat-${PV}"

LICENSE="MIT LGPL-2.1-with-linking-exception"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-ml/base-0.12.0:=
	dev-ml/dune-build-info:=
	dev-ml/either:=
	dev-ml/fix:=
	dev-ml/fpath:=
	>=dev-ml/menhir-20201216:=
	>=dev-ml/ocaml-version-3.5.0:=
	>=dev-util/ocp-indent-1.8.0:=
	dev-ml/stdio:=
	>=dev-ml/uuseg-10.0.0:=
	>=dev-ml/uutf-1.0.1:=
	>=dev-ml/csexp-1.4.0:=
	dev-ml/astring:=
	dev-ml/result:=
	dev-ml/camlp-streams:=
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	test? (
		>=dev-ml/alcotest-1.3.0:=
		~dev-ml/ocamlformat-rpc-lib-${PV}:=
		>=dev-util/ocp-indent-1.8.1:=
	)
"

src_compile() {
	dune-compile ocamlformat-lib
}

src_install() {
	dune-install ocamlformat-lib
}
