# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="A super-fast epoll-backed and parallel HTTP server"
HOMEPAGE="
	https://github.com/dom96/httpbeast
	https://nimble.directory/pkg/httpbeast
"
SRC_URI="https://github.com/dom96/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-nim/asynctools )"
RDEPEND="${DEPEND}"

set_package_url "https://github.com/dom96/httpbeast"

src_prepare() {
	default

	use test || nimble_comment_requires asynctools
	sed "s/nimble c -y/nim c/g" -i tests/tester.nim || die
}

src_test() {
	enim r tests/tester
}
