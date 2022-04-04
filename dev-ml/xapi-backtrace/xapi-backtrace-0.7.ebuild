# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune findlib

DESCRIPTION="Helper functions to preserve and transport exception backtraces"
HOMEPAGE="https://github.com/xapi-project/backtrace"
SRC_URI="https://github.com/xapi-project/backtrace/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/backtrace-${PV}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/ppx_sexp_conv
	dev-ml/rpc
"
RDEPEND="${DEPEND}"
