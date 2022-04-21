# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="OCaml bindings for Linux epoll(2)"
HOMEPAGE="
	https://github.com/lindig/polly
	https://opam.ocaml.org/packages/polly/
"
SRC_URI="https://github.com/lindig/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-lang/ocaml:=[ocamlopt?]
	dev-ml/cmdliner:=
"
DEPEND="${RDEPEND}"
