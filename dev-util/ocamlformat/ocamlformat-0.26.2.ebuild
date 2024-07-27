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
	dev-ml/cmdliner:=
	dev-ml/csexp:=
	dev-ml/re:=

	dev-ml/base:=
	dev-ml/dune-build-info:=
	dev-ml/either:=
	dev-ml/fix:=
	dev-ml/fpath:=
	dev-ml/menhir:=
	dev-ml/ocaml-version:=
	dev-util/ocp-indent:=
	dev-ml/stdio:=
	dev-ml/uuseg:=
	dev-ml/uutf:=
	dev-ml/astring:=
	dev-ml/camlp-streams:=
"

DEPEND="
	${RDEPEND}
"

BEPEND="
	test? (
		dev-ml/alcotest:=
	)
"
