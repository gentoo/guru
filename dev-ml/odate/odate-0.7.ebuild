# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Date & Duration Library"
HOMEPAGE="https://github.com/hhugo/odate"
SRC_URI="https://github.com/hhugo/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

# Tests are broken
# see https://github.com/hhugo/odate/issues/7
RESTRICT="test"

RDEPEND="
	>=dev-ml/menhir-20230608:=[ocamlopt?]
	>=dev-lang/ocaml-4.07:=[ocamlopt?]
"
DEPEND="${RDEPEND}"
