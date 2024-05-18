# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

COMMIT="cb4bfef79f2e7e509fc7d94ae9da4d2b795b764e"
DESCRIPTION="Data structure view templates for Crystal"
HOMEPAGE="https://github.com/domgetter/crikey"
SRC_URI="https://github.com/domgetter/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test" # broken
