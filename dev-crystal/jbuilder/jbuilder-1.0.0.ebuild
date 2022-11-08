# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Generate JSON objects with a Builder-style DSL"
HOMEPAGE="https://github.com/shootingfly/jbuilder"
SRC_URI="https://github.com/shootingfly/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
