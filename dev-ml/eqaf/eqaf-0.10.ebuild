# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Constant time equal function to avoid timing attacks in OCaml"
HOMEPAGE="https://github.com/mirage/eqaf"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DOCS=( README.md CHANGES.md )

RDEPEND="
	>=dev-lang/ocaml-4.3:=[ocamlopt?]
	>=dev-ml/cstruct-1.10:=[ocamlopt?]
"
DEPEND="${RDEPEND}"
