# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Emile is a library to parse an e-mail address in OCaml"
HOMEPAGE="https://github.com/mirage/emile"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${PN}-v${PV}.tbz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/angstrom
	dev-ml/ipaddr
	dev-ml/ocaml-base64
	dev-ml/pecu
	dev-ml/bigstringaf
	dev-ml/uutf
	dev-ml/fmt
"
RDEPEND="${DEPEND}"
