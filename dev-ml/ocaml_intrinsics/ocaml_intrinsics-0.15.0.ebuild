# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Functions to invoke amd64 instructions when available"
HOMEPAGE="https://github.com/janestreet/ocaml_intrinsics"
SRC_URI="https://github.com/janestreet/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="dev-ml/dune-configurator"
DEPEND="${RDEPEND}"

RESTRICT="test" # even upstream doesn't know how to test
