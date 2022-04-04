# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Little cli tool to convert md files into mld files"
HOMEPAGE="https://github.com/mseri/md2mld"
SRC_URI="https://github.com/mseri/${PN}/releases/download/${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/base
	dev-ml/omd
"
RDEPEND="${DEPEND}"
