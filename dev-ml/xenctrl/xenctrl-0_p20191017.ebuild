# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

COMMIT="b9e147ed2e818b47563555cfc059e1d8a7fcf6c3"

DESCRIPTION="Mock OCaml bindings for the Xen Hypervisor"
HOMEPAGE="https://github.com/lindig/xenctrl"
SRC_URI="https://github.com/lindig/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="app-emulation/xen"
RDEPEND="${DEPEND}"
