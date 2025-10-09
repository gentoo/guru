# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME=tsort
inherit dune

DESCRIPTION="Easy to use and user-friendly topological sort"
HOMEPAGE="https://github.com/dmbaturin/ocaml-tsort"
SRC_URI="https://github.com/dmbaturin/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DOCS=( README.md CHANGES.md )

RDEPEND="
	>=dev-ml/dune-1.9
	>=dev-lang/ocaml-4.3:=[ocamlopt?]
"
DEPEND="${RDEPEND}"
