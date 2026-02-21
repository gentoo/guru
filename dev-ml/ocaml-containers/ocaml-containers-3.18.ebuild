# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="containers"
inherit dune

DESCRIPTION="Modular, clean and powerful extension of the OCaml standard library"
HOMEPAGE="https://github.com/c-cube/ocaml-containers"
SRC_URI="https://github.com/c-cube/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-ml/seq:=[ocamlopt?]
	dev-ml/either:=[ocamlopt?]
	dev-ml/dune-configurator:=[ocamlopt?]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-ml/qcheck-0.91:=[ocamlopt?]
		dev-ml/yojson:=[ocamlopt?]
		dev-ml/iter:=[ocamlopt?]
		dev-ml/gen:=[ocamlopt?]
		dev-ml/csexp:=[ocamlopt?]
		dev-ml/uutf:=[ocamlopt?]
		dev-ml/mdx:=[ocamlopt?]
	)
"
