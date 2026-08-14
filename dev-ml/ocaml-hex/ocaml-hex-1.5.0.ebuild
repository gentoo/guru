# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="hex"
inherit dune

DESCRIPTION="Hexadecimal converter"
HOMEPAGE="https://github.com/mirage/ocaml-hex"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DOCS=( README.md CHANGES.md )

DEPEND="
	>=dev-lang/ocaml-4.08.0[ocamlopt?]
	>=dev-ml/cstruct-1.7.0
"
RDEPEND="${DEPEND}"
