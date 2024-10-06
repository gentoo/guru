# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Auto-formatter for OCaml code"
HOMEPAGE="https://github.com/ocaml-ppx/ocamlformat"
SRC_URI="https://github.com/ocaml-ppx/ocamlformat/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-ml/cmdliner-1.1.0:=
	~dev-ml/ocamlformat-lib-${PV}:=
	>=dev-ml/re-1.10.3:=
"

DEPEND="
	${RDEPEND}
"

# Includes testing dependencies of `ocamlformat-lib`.
BDEPEND="
	test? (
		>=dev-ml/cmdliner-1.2.0:=
		~dev-ml/ocamlformat-rpc-lib-${PV}:=

		>=dev-ml/alcotest-1.3.0:=
		>=dev-util/ocp-indent-1.8.1:=
	)
"

src_prepare() {
	default

	sed -i "/^(name ocamlformat)/a (version ${PV})" dune-project || die
}

src_compile() {
	dune-compile ocamlformat
}

src_install() {
	dune-install ocamlformat
}
