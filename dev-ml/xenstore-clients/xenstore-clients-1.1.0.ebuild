# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dune findlib

DESCRIPTION="Unix client tools for accessing xenstore"
HOMEPAGE="https://github.com/xapi-project/ocaml-xenstore-clients"
SRC_URI="https://github.com/xapi-project/ocaml-${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/cstruct
	dev-ml/xenstore
"
RDEPEND="${DEPEND}"

src_install() {
	dune_src_install xenstore_transport
	dune_src_install xenstore-tool
}
