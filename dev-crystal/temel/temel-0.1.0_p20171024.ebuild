# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

COMMIT="f7ddd6d70ff9f13ec00fa49f9ede68bb4650caf9"
DESCRIPTION="Extensible Markup DSL for Crystal"
HOMEPAGE="https://github.com/f/temel"
SRC_URI="https://github.com/f/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
