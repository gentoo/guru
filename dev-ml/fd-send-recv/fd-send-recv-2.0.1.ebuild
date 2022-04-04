# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="ocaml-${PN}"

inherit dune

DESCRIPTION="Send and receive Unix.file_descrs over Unix domain sockets"
HOMEPAGE="https://github.com/xapi-project/ocaml-fd-send-recv"
SRC_URI="https://github.com/xapi-project/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="dev-ml/tuntap"
RDEPEND="${DEPEND}"
