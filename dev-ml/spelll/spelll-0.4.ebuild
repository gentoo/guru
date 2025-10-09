# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Fuzzy string searching, using Levenshtein automaton"
HOMEPAGE="https://github.com/c-cube/spelll"
SRC_URI="https://github.com/c-cube/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

DOCS=( README.md )

RDEPEND="
	dev-ml/seq:=[ocamlopt?]
	dev-ml/stdlib-shims:=[ocamlopt?]
	>=dev-lang/ocaml-4.03.0:=[ocamlopt?]
"
DEPEND="${RDEPEND}"
