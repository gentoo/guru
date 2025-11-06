# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="HTTP::Client for testing HTTP::Handlers directly and maintaining cookies"
HOMEPAGE="https://github.com/crystal-loot/webless"
SRC_URI="https://github.com/crystal-loot/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		dev-crystal/spectator
	)
"
