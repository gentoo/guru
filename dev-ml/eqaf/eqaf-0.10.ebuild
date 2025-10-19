# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Constant time equal function to avoid timing attacks in OCaml"
HOMEPAGE="https://github.com/mirage/eqaf"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"

RESTRICT="!test? ( test )"

DOCS=( README.md CHANGES.md )

RDEPEND="
	>=dev-lang/ocaml-4.3:=[ocamlopt?]
	>=dev-ml/cstruct-1.10:=[ocamlopt?]
"

DEPEND="
	${RDEPEND}
	test? (
		>=dev-ml/ocaml-base64-3.0.0:=[ocamlopt?]
		dev-ml/alcotest:=[ocamlopt?]
		dev-ml/crowbar:=[ocamlopt?]
		>=dev-ml/fmt-0.8.7:=[ocamlopt?]
	)
"
