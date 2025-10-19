# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Hashes implementations (SHA*, RIPEMD160, BLAKE2* and MD5)"
HOMEPAGE="https://github.com/mirage/digestif"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-lang/ocaml-4.8:=[ocamlopt?]
	dev-ml/eqaf:=[ocamlopt?]
"

DEPEND="
	${RDEPEND}
	test? (
		>=dev-ml/fmt-0.8.7:=[ocamlopt?]
		dev-ml/alcotest:=[ocamlopt?]
		dev-ml/bos
		dev-ml/astring
		dev-ml/fpath
		dev-ml/rresult
		dev-ml/findlib:=[ocamlopt?]
		dev-ml/crowbar:=[ocamlopt?]
	)
"
