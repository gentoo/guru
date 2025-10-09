# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="An embeddable Lua 2.5 interpreter implemented in OCaml"
HOMEPAGE="https://github.com/lindig/lua-ml"
SRC_URI="https://github.com/lindig/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="
	>=dev-lang/ocaml-4.7:=[ocamlopt?]
	dev-ml/menhir:=[ocamlopt?]
"
DEPEND="${RDEPEND}"
