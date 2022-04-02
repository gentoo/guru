# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="Caml on the Web"
HOMEPAGE="
	http://www.openmirage.org/
	https://github.com/mirage/ocaml-cow
"
SRC_URI="https://github.com/mirage/ocaml-cow/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/ezjsonm
	dev-ml/omd
	dev-ml/uri
	dev-ml/xmlm
"
RDEPEND="${DEPEND}"
