# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="S-expression pretty-printer"
HOMEPAGE="https://github.com/janestreet/sexp_pretty"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/base
	dev-ml/ppx_base
	dev-ml/sexplib
	dev-ml/re
"
DEPEND="${RDEPEND}"
