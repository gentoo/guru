# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Communicate with dune using rpc"
HOMEPAGE="
	https://opam.ocaml.org/packages/dune-rpc/
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
	dev-ml/csexp:=
	dev-ml/ordering:=
	dev-ml/dyn:=
	dev-ml/xdg:=
	~dev-ml/stdune-${PV}:=
	>=dev-ml/pp-1.1.0:=
"

DEPEND="
	${RDEPEND}
"

src_configure() {
	:
}

src_compile() {
	dune-compile dune-rpc
}

src_install() {
	dune-install dune-rpc
}
