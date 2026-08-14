# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME=csv
inherit dune

DESCRIPTION="CSV library for OCaml"
HOMEPAGE="https://github.com/Chris00/ocaml-csv"
SRC_URI="https://github.com/Chris00/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

# license: "LGPL-2.1 with OCaml linking exception"
LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="
	dev-ml/lwt:=[ocamlopt?]
	>=dev-ml/uutf-1.0.0:=[ocamlopt?]
	>=dev-lang/ocaml-4.03:=[ocamlopt?]
"
DEPEND="${RDEPEND}"
