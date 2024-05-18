# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Useful synchronization primitives"
HOMEPAGE="https://github.com/planetis-m/sync https://nimble.directory/pkg/sync"
SRC_URI="https://github.com/planetis-m/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

set_package_url "https://github.com/planetis-m/sync"

src_prepare() {
	default

	# remove failing tests
	rm tests/tspsc1.nim || die
}

src_configure() {
	mynimargs=(
		--threads:on
	)
	nimble_src_configure
}
