# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Radix tree implementation for Crystal language"
HOMEPAGE="https://github.com/luislavena/radix"
SRC_URI="https://github.com/luislavena/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {CHANGELOG,README}.md )
