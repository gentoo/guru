# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml library for manipulation of IP (and MAC) address representations"
HOMEPAGE="https://github.com/mirage/ocaml-ipaddr"
SRC_URI="https://github.com/mirage/ocaml-ipaddr/archive/v${PV}.tar.gz -> ocaml-${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/cstruct
	dev-ml/domain-name
	dev-ml/ppx_sexp_conv
	dev-ml/sexplib0
"
DEPEND="${RDEPEND}"

src_install() {
	dune_src_install ipaddr
	dune_src_install ipaddr-cstruct
	dune_src_install ipaddr-sexp
	dune_src_install macaddr
	dune_src_install macaddr-cstruct
	dune_src_install macaddr-sexp
}
