# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

MYPN="ocaml-${PN}"

DESCRIPTION="Read and write .vhd-format format data"
HOMEPAGE="
	https://github.com/mirage/ocaml-vhd
	https://opam.ocaml.org/packages/vhd-format/
"
SRC_URI="https://github.com/mirage/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="lwt ocamlopt test"

RDEPEND="
	dev-ml/cstruct:=
	dev-ml/io-page:=
	dev-ml/rresult:=
	dev-ml/uuidm:=
	dev-ml/stdlib-shims:=

	lwt? (
		dev-ml/mirage-block:=
		dev-ml/lwt:=
	)
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/ounit2
		dev-ml/io-page[unix(-)]
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( lwt )"
PATCHES="${FILESDIR}/${P}-ounit2.patch"

src_compile() {
	local pkgs="vhd-format"
	use lwt && pkgs="${pkgs},vhd-format-lwt"
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install vhd-format
	use lwt && dune_src_install vhd-format-lwt
}
