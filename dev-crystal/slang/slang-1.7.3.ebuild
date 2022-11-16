# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Slim-inspired templating language for Crystal"
HOMEPAGE="https://github.com/jeromegn/slang"
SRC_URI="https://github.com/jeromegn/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
