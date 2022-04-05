# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Async helpers for writing expectation tests"
HOMEPAGE="https://github.com/janestreet/expect_test_helpers"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/async
	dev-ml/core
	dev-ml/expect_test_helpers_kernel
	dev-ml/ppx_jane
	dev-ml/sexp_pretty
"
DEPEND="${RDEPEND}"
