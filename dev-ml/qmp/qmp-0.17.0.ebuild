# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYPN="ocaml-${PN}"

DESCRIPTION="A Qemu Message Protocol (QMP) client in OCaml"
HOMEPAGE="
	https://github.com/xapi-project/ocaml-qmp
	https://opam.ocaml.org/packages/qmp/
"
SRC_URI="https://github.com/xapi-project/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

DEPEND="
	dev-ml/base-unix:=
	dev-ml/yojson:=
	dev-ml/cmdliner:=
"
RDEPEND="
	${DEPEND}
	test? ( dev-ml/ounit2 )
"

RESTRICT="!test? ( test )"
PATCHES="${FILESDIR}/${P}-ounit2.patch"
