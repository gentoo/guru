# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="A library for displaying exceptional exception pages for easier debugging"
HOMEPAGE="https://github.com/crystal-loot/exception_page"
SRC_URI="https://github.com/crystal-loot/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-crystal/backtracer"
BDEPEND="
	test? (
		dev-crystal/lucky_flow
	)
"

src_prepare() {
	default

	# test error, related to lucky_flow ('be_on_page' method)
	rm spec/exception_page_spec.cr || die
}
