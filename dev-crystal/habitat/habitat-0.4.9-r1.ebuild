# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Easily configure settings for Crystal projects"
HOMEPAGE="https://github.com/luckyframework/habitat"
SRC_URI="https://github.com/luckyframework/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {CODE_OF_CONDUCT,CONTRIBUTING,README}.md )
