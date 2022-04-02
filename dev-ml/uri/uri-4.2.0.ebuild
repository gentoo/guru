# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="RFC3986 URI parsing library for OCaml"
HOMEPAGE="https://github.com/mirage/ocaml-uri"
SRC_URI="https://github.com/mirage/ocaml-uri/archive/v${PV}.tar.gz -> ocaml-${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/angstrom
	dev-ml/ppx_sexp_conv
	dev-ml/re
	dev-ml/sexplib0
	dev-ml/stringext
"
DEPEND="${RDEPEND}"

src_install() {
	dune_src_install uri
	dune_src_install uri-re
	dune_src_install uri-sexp
}
