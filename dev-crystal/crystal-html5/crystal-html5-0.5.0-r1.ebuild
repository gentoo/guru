# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Pure Crystal implementation of an HTML5-compliant Tokenizer and Parser"
HOMEPAGE="https://github.com/naqvis/crystal-html5"
SRC_URI="https://github.com/naqvis/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-crystal/crystal-xpath2"
