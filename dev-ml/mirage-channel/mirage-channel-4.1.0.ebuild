# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="An implementation of channels using page-aligned memory"
HOMEPAGE="https://github.com/mirage/mirage-time"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/cstruct
	dev-ml/logs
	dev-ml/lwt
	dev-ml/mirage-flow
"
DEPEND="${RDEPEND}"
