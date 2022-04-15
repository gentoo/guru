# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="OCaml Ethernet (IEEE 802.3) layer"
HOMEPAGE="https://github.com/mirage/ethernet"
SRC_URI="https://github.com/mirage/${PN}/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/mirage-net
	dev-ml/ipaddr
	dev-ml/mirage-profile
	dev-ml/lwt
	dev-ml/logs
	>=dev-ml/cstruct-6.0.0[ppx]
"
DEPEND="${RDEPEND}"
