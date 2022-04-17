# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="OCaml library for manipulation of IP (and MAC) address representations"
HOMEPAGE="
	https://github.com/mirage/ocaml-ipaddr
	https://opam.ocaml.org/packages/ipaddr/
"
SRC_URI="https://github.com/mirage/ocaml-ipaddr/archive/v${PV}.tar.gz -> ocaml-${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="cstruct macaddr-cstruct macaddr-sexp ocamlopt sexp test"

RDEPEND="
	dev-ml/domain-name:=
	dev-ml/stdlib-shims:=

	cstruct? ( dev-ml/cstruct:= )
	macaddr-cstruct? ( dev-ml/cstruct:= )
	macaddr-sexp? (
		dev-ml/ppx_sexp_conv:=
		dev-ml/sexplib0:=
	)
	sexp? (
		dev-ml/ppx_sexp_conv:=
		dev-ml/sexplib0:=
	)
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/ounit2
		dev-ml/ppx_sexp_conv
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( cstruct macaddr-cstruct macaddr-sexp sexp )"
PATCHES="${FILESDIR}/${P}-ounit2.patch"

src_compile() {
	local pkgs="ipaddr,macaddr"
	for u in cstruct sexp ; do
		if use ${u} ; then
			pkgs="${pkgs},ipaddr-${u}"
		fi
		if use macaddr-${u} ; then
			pkgs="${pkgs},macaddr-${u}"
		fi
	done

	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install macaddr
	dune_src_install ipaddr
	use cstruct && dune_src_install ipaddr-cstruct
	use sexp && dune_src_install ipaddr-sexp
	use macaddr-cstruct && dune_src_install macaddr-cstruct
	use macaddr-sexp && dune_src_install macaddr-sexp
}
