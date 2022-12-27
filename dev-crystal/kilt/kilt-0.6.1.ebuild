# Copyright 2022 Gentoo Authors
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

RDEPEND="dev-crystal/crikey"
BDEPEND="
	doc? (
		dev-crystal/crustache
	)
	test? (
		dev-crystal/crustache
		dev-crystal/jbuilder
		dev-crystal/liquid
		dev-crystal/slang
		dev-crystal/temel
		dev-crystal/water
	)
"
