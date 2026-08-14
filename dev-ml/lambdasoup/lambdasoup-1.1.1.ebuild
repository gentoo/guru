# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Functional HTML scraping and manipulation library"
HOMEPAGE="https://aantron.github.io/lambdasoup"
SRC_URI="https://github.com/aantron/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-ml/markup:=[ocamlopt?]
	dev-ml/camlp-streams:=[ocamlopt?]
	>=dev-ml/dune-2.7.0
	>=dev-lang/ocaml-4.03.0:=[ocamlopt?]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/ounit2:=[ocamlopt?]
	)
"
