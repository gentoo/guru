# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit shards

DESCRIPTION="HTTP Proxy server and client written in Crystal"
HOMEPAGE="https://github.com/mamantoha/http_proxy"
SRC_URI="https://github.com/mamantoha/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS=( {CHANGELOG,README}.md )

DEPEND="
	test? ( dev-crystal/webmock )
"

src_test() {
	# Only run tests that don't need net.
	crystal_spec --tag "~network"
}
