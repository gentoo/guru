# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYPV="${PV/_alpha/.alpha}"

DESCRIPTION="An easy interface on top of the Jsonm library"
HOMEPAGE="https://github.com/ocaml/omd"
SRC_URI="https://github.com/ocaml/omd/releases/download/${MYPV}/${PN}-${MYPV}.tbz"
S="${WORKDIR}/${PN}-${MYPV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/dune-build-info
"
RDEPEND="${DEPEND}"
