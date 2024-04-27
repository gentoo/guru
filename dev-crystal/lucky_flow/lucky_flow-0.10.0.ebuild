# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="LuckyFlow is a library for testing user flows in the browser"
HOMEPAGE="https://github.com/luckyframework/lucky_flow"
SRC_URI="https://github.com/luckyframework/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-crystal/crystal-html5
	dev-crystal/habitat
	dev-crystal/selenium
	dev-crystal/webdrivers
	dev-crystal/webless
"

src_test() {
	shards_src_test --tag "~headless_chrome" --tag "~headless_firefox"
}
