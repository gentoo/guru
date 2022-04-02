# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune findlib

DESCRIPTION="The XCP inventory library"
HOMEPAGE="https://github.com/xapi-project/xcp-inventory"
SRC_URI="https://github.com/xapi-project/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/astring
	dev-ml/cmdliner
	dev-ml/uuidm
	dev-ml/xapi-stdext
"
RDEPEND="${DEPEND}"

src_install() {
	dune_src_install xapi-inventory
}
