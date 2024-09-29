# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="LSP Server for OCaml"
HOMEPAGE="https://github.com/ocaml/ocaml-lsp"
SRC_URI="https://github.com/ocaml/ocaml-lsp/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocaml-lsp-${PV}"

LICENSE="ISC"

SLOT="0"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-ml/dune-3.0:=
	dev-ml/yojson:=
	dev-ml/base:=
	~dev-ml/lsp-${PV}:=
	~dev-ml/jsonrpc-${PV}:=
	>=dev-ml/re-1.5.0:=
	>=dev-ml/ppx_yojson_conv_lib-0.14:=
	>=dev-ml/dune-rpc-3.4.0:=
	>=dev-ml/chrome-trace-3.3.0:=
	dev-ml/dune-private-libs:=
	>=dev-ml/fiber-3.3.1:= <dev-ml/fiber-4.0.0:=
	dev-ml/xdg:=
	dev-ml/dune-build-info:=
	dev-ml/spawn:=
	dev-ml/astring:=
	dev-ml/camlp-streams:=
	>=dev-ml/ocamlc-loc-3.7.0:=
	>=dev-ml/pp-1.1.2:=
	>=dev-ml/csexp-1.5:=
	>=dev-ml/ocamlformat-rpc-lib-0.21.0:=
	>=dev-lang/ocaml-4.14:= <dev-lang/ocaml-5.2:=
	>=dev-ml/merlin-lib-4.16:= <dev-ml/merlin-lib-5.0
"

DEPEND="
	${RDEPEND}
"

# Includes test dependencies of `lsp` too.
BEPEND="
	test? (
		>=dev-ml/ppx_expect-0.15.0:=
		~dev-ml/ocamlformat-0.26.2:=

		dev-ml/cinaps:=
	)
"

src_compile() {
	dune-compile ${PN}
}

src_install() {
	dune-install ${PN}
}

src_test() {
	# `make test` runs unit and e2e tests, but e2e ones are managed by `yarn`,
	# and we cannot run it in the sandboxed, offline environment.
	emake test-ocaml
}
