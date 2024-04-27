# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

MY_PN="${PN}.cr"
DESCRIPTION="Helps manage drivers for Selenium, such as the Chromedriver"
HOMEPAGE="https://github.com/matthewmcgarvey/webdrivers.cr"
SRC_URI="https://github.com/matthewmcgarvey/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-crystal/crystar
	dev-crystal/habitat
"

src_prepare() {
	default

	# remove tests that use network
	rm \
		spec/webdrivers/chromedriver_spec.cr \
		spec/webdrivers/geckodriver_spec.cr \
		spec/webdrivers/chrome/driver_remote_version_finder_spec.cr || die
}
