# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Query the state and contents of CDROM devices under Linux"
HOMEPAGE="https://github.com/xapi-project/cdrom"
SRC_URI="https://github.com/xapi-project/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"
