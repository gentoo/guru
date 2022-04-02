# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A Xenstore protocol implementation in pure OCaml"
HOMEPAGE="https://github.com/mirage/ocaml-xenstore"
SRC_URI="https://github.com/mirage/ocaml-${PN}/releases/download/${PV}/${P}.tbz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/cstruct
	dev-ml/lwt
"
RDEPEND="${DEPEND}"
