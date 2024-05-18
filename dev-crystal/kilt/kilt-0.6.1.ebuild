# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Generic template interface for Crystal"
HOMEPAGE="https://github.com/jeromegn/kilt"
SRC_URI="https://github.com/jeromegn/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

TEST_DEPEND="
	dev-crystal/crustache
	dev-crystal/jbuilder
	dev-crystal/liquid
	dev-crystal/slang
	dev-crystal/temel
	dev-crystal/water
"
RDEPEND="dev-crystal/crikey"
DEPEND="
	doc? ( ${TEST_DEPEND} )
	test? ( ${TEST_DEPEND} )
"
