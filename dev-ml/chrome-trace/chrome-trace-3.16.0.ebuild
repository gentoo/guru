# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Chrome trace event generation library"
HOMEPAGE="
	https://opam.ocaml.org/packages/chrome-trace/
	https://github.com/ocaml/dune/
"
SRC_URI="https://github.com/ocaml/dune/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/dune-${PV}"

LICENSE="MIT"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt"

RESTRICT="test"

RDEPEND="
	>=dev-ml/dune-3.12:=
	>=dev-lang/ocaml-4.08.0:=
"

DEPEND="
	${RDEPEND}
"

src_configure() {
	:
}

src_compile() {
	dune-compile chrome-trace
}
