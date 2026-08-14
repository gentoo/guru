# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Simple iterator abstract datatype"
HOMEPAGE="https://c-cube.github.io/iter"
SRC_URI="https://github.com/c-cube/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"
RESTRICT="test"

RDEPEND="
	>=dev-ml/dune-2.0
	>=dev-lang/ocaml-4.08:=[ocamlopt?]
"
DEPEND="${RDEPEND}"
