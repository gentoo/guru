# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="An easy interface on top of the Jsonm library"
HOMEPAGE="https://github.com/mirage/ezjsonm"
SRC_URI="https://github.com/mirage/ezjsonm/releases/download/v${PV}/${PN}-v${PV}.tbz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/hex
	>=dev-ml/jsonm-1.0.0
	dev-ml/lwt
	dev-ml/sexplib0
	dev-ml/uutf
"
RDEPEND="${DEPEND}"

src_install() {
	dune_src_install ezjsonm
	dune_src_install ezjsonm-lwt
}
