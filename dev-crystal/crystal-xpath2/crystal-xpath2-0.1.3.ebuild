# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="XPath implementation in Crystal"
HOMEPAGE="https://github.com/naqvis/crystal-xpath2"
SRC_URI="https://github.com/naqvis/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-crystal/crystal-fnv"
