# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYPN="ocaml-${PN}"

DESCRIPTION="mustache.js logic-less templates in OCaml"
HOMEPAGE="
	https://github.com/rgrinberg/ocaml-mustache
	https://opam.ocaml.org/packages/mustache/
"
SRC_URI="https://github.com/rgrinberg/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

DEPEND="
	dev-ml/menhir:=
	dev-ml/ezjsonm:=
"
RDEPEND="
	${DEPEND}
	test? ( dev-ml/ounit )
"

RESTRICT="!test? ( test )"
