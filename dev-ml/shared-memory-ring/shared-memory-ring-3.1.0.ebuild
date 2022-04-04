# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Xen-style shared memory rings"
HOMEPAGE="https://github.com/mirage/shared-memory-ring"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/cstruct
	dev-ml/lwt
	dev-ml/lwt-dllist
	dev-ml/mirage-profile
"
DEPEND="${RDEPEND}"

src_install() {
	dune_src_install shared-memory-ring
	dune_src_install shared-memory-ring-lwt
}
