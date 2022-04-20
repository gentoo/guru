# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Directory traversal with Async"
HOMEPAGE="
	https://github.com/janestreet/async_find
	https://opam.ocaml.org/packages/async_find/
"
SRC_URI="https://github.com/janestreet/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	>=dev-lang/ocaml-4.08.0:=[ocamlopt?]
	=dev-ml/async-0.14*
	=dev-ml/core-0.14*
	=dev-ml/ppx_jane-0.14*
"
RDEPEND="${DEPEND}"
