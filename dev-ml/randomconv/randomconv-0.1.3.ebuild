# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="Convert from random bytes to random native numbers"
HOMEPAGE="https://github.com/hannesm/randomconv"
SRC_URI="https://github.com/hannesm/${PN}/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="dev-ml/cstruct"
DEPEND="${RDEPEND}"
