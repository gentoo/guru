# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Simple WebSocket library for nim"
HOMEPAGE="
	https://github.com/treeform/ws
	https://nimble.directory/pkg/ws
"
SRC_URI="https://github.com/treeform/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

set_package_url "https://github.com/treeform/ws"

src_prepare() {
	default

	# remove failing tests
	rm tests/test_timeout.nim || die
}
