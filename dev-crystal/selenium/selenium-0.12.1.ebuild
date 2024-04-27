# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

MY_PN="${PN}.cr"
DESCRIPTION="Selenium library for Crystal"
HOMEPAGE="
	https://matthewmcgarvey.github.io/selenium.cr/
	https://github.com/matthewmcgarvey/selenium.cr
"
SRC_URI="https://github.com/matthewmcgarvey/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="test"
PROPERTIES="test_network"

BDEPEND="
	test? (
		dev-crystal/webdrivers
		|| (
			www-client/firefox:*
			www-client/firefox-bin:*
		)
	)
"

src_test() {
	local -x SELENIUM_BROWSER=firefox
	ecrystal spec --tag "~firefox"
}
