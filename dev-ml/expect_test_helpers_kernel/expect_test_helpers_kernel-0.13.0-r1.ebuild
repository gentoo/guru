# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Helpers for writing expectation tests"
HOMEPAGE="https://github.com/janestreet/expect_test_helpers_kernel"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/base
	dev-ml/base_quickcheck
	dev-ml/core_kernel
	dev-ml/ppx_jane
	dev-ml/sexp_pretty
	dev-ml/stdio
	dev-ml/re
"
DEPEND="${RDEPEND}"
