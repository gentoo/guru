# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Execute code blocks inside your documentation"
HOMEPAGE="https://github.com/realworldocaml/mdx"
SRC_URI="https://github.com/realworldocaml/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-ml/dune-3.5
	>=dev-lang/ocaml-4.08.0
	dev-ml/findlib:=[ocamlopt?]
	>=dev-ml/fmt-0.8.7:=[ocamlopt?]
	>=dev-ml/csexp-1.3.2:=[ocamlopt?]
	dev-ml/astring
	>=dev-ml/logs-0.7.0:=[cli,ocamlopt?]
	>=dev-ml/cmdliner-1.1.0:=[ocamlopt?]
	>=dev-ml/re-1.7.2:=[ocamlopt?]
	dev-ml/camlp-streams:=[ocamlopt?]
	dev-ml/result:=[ocamlopt?]
	dev-ml/ocaml-version:=[ocamlopt?]
"
DEPEND="
	${RDEPEND}
	>=dev-ml/cppo-1.1.0:=[ocamlopt?]
	test? (
		dev-ml/lwt:=[ocamlopt?]
	)
"
