# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="TOML parsing, manipulation, and pretty-printing library"
HOMEPAGE="https://github.com/dmbaturin/otoml"
SRC_URI="https://github.com/dmbaturin/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DOCS=( README.md CHANGELOG.md )

RDEPEND="
	dev-ml/menhir:=[ocamlopt?]
	>=dev-ml/uutf-1.0.0:=[ocamlopt?]
	>=dev-lang/ocaml-4.08:=[ocamlopt?]
	>=dev-ml/dune-2.0.0
"
DEPEND="${RDEPEND}"
