# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

MY_PN="${PN}.cr"
DESCRIPTION="Provides the legacy JSON.mapping macro method"
HOMEPAGE="https://github.com/crystal-lang/json_mapping.cr"
SRC_URI="https://github.com/crystal-lang/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
