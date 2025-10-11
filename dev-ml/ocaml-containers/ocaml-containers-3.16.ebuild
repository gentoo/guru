# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="containers"
inherit dune

DESCRIPTION="Modular, clean and powerful extension of the OCaml standard library"
HOMEPAGE="https://github.com/c-cube/ocaml-containers"
SRC_URI="https://github.com/c-cube/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="
	dev-ml/seq:=[ocamlopt?]
	dev-ml/either:=[ocamlopt?]
	dev-ml/dune-configurator:=[ocamlopt?]
"
DEPEND="${RDEPEND}"
