# Copyright 2019-2022 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mix

DESCRIPTION="Package manager for the Erlang VM"
HOMEPAGE="https://github.com/hexpm/hex"
LICENSE="Apache-2.0"
SLOT="$(ver_cut 1-2)"
SRC_URI="https://github.com/hexpm/hex/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

# TODO: tests (requires dependencies)
