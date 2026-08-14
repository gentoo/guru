# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
	# Upstream issue: https://github.com/mamantoha/http_proxy/issues/38
	crystal_spec \
		"${S}"/spec/client_spec.cr:5 \
		"${S}"/spec/client_spec.cr:13 \
		"${S}"/spec/client_spec.cr:21 \
		"${S}"/spec/client_spec.cr:53 \
		"${S}"/spec/client_spec.cr:101 \
		"${S}"/spec/server_spec.cr:5 \
		"${S}"/spec/server_spec.cr:10
}
