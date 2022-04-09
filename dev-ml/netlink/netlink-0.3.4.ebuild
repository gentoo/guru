# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYPN="ocaml-${PN}"

DESCRIPTION="OCaml bindings to libnl"
HOMEPAGE="https://github.com/xapi-project/ocaml-netlink"
SRC_URI="https://github.com/xapi-project/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-libs/libnl:3
	dev-ml/ocaml-ctypes
"
RDEPEND="${DEPEND}"
