# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="An easy-to-use Xenstore library"
HOMEPAGE="https://github.com/xapi-project/ezxenstore"
SRC_URI="https://github.com/xapi-project/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/cmdliner
	dev-ml/logs
	dev-ml/uuidm
	dev-ml/xenctrl
	dev-ml/xenstore
	dev-ml/xenstore-clients
"
RDEPEND="${DEPEND}"
