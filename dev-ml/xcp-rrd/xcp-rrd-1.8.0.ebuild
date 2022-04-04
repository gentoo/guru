# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="RRD library for use with xapi"
HOMEPAGE="https://github.com/xapi-project/xcp-rrd"
SRC_URI="https://github.com/xapi-project/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/base
	dev-ml/ezjsonm
	dev-ml/ppx_deriving
	dev-ml/xmlm
	dev-ml/uuidm
"
RDEPEND="${DEPEND}"

src_install() {
	dune_src_install xapi-rrd
}
