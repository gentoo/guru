# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYP="${PN}-v${PV}"

DESCRIPTION="Unix core platform libraries for MirageOS"
HOMEPAGE="https://github.com/mirage/mirage-unix"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/duration
	dev-ml/io-page
	dev-ml/lwt
	dev-ml/mirage
"
DEPEND="${RDEPEND}"
