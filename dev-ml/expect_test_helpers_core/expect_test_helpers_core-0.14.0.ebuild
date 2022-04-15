# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Helpers for writing expectation tests"
HOMEPAGE="https://github.com/janestreet/expect_test_helpers_core"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

#	<dev-lang/ocaml-4.14
RDEPEND="
	>=dev-lang/ocaml-4.08.0
	=dev-ml/base-0.14*
	=dev-ml/base_quickcheck-0.14*
	=dev-ml/core-0.14*
	=dev-ml/ppx_jane-0.14*
	=dev-ml/sexp_pretty-0.14*
	=dev-ml/stdio-0.14*
	>=dev-ml/re-1.8.0
"
DEPEND="${RDEPEND}"
