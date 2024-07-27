# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Library to parse and enumerate releases of the OCaml compiler"
HOMEPAGE="https://github.com/ocurrent/ocaml-version"
SRC_URI="https://github.com/ocurrent/ocaml-version/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		dev-ml/alcotest:=
	)
"
