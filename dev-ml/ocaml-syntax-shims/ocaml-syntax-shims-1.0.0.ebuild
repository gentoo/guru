# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Backport new syntax to older compilers"
HOMEPAGE="https://github.com/ocaml-ppx/ocaml-syntax-shims"
SRC_URI="https://github.com/ocaml-ppx/ocaml-syntax-shims/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"
