# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

BASE_PN="mirage-clock"

DESCRIPTION="Unix-based implementation for the MirageOS Clock interface"
HOMEPAGE="https://github.com/mirage/mirage-clock"
SRC_URI="https://github.com/mirage/mirage-clock/releases/download/v${PV}/${BASE_PN}-v${PV}.tbz"
S="${WORKDIR}/${BASE_PN}-v${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="dev-ml/mirage-clock:="
RDEPEND="${DEPEND}"
BDEPEND="dev-ml/dune-configurator"
