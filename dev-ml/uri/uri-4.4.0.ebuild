# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="RFC3986 URI parsing library for OCaml"
HOMEPAGE="https://github.com/mirage/ocaml-uri"
SRC_URI="https://github.com/mirage/ocaml-uri/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/ocaml-uri-${PV}"

LICENSE="ISC"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-ml/angstrom:=
	dev-ml/ppx_sexp_conv:=
	dev-ml/stringext:=
	dev-ml/core_bench:=
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	test? (
		dev-ml/ounit2:=
		dev-ml/crowbar:=
		dev-ml/core_bench:=
	)
"
