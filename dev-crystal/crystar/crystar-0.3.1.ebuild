# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Crystal language Tar Module implements access to tar archives"
HOMEPAGE="https://github.com/naqvis/crystar"
SRC_URI="https://github.com/naqvis/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
