# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="A sinatra-like web framework for Nim"
HOMEPAGE="
	https://github.com/dom96/jester
	https://nimble.directory/pkg/jester
"
SRC_URI="https://github.com/dom96/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"
IUSE="test"

# can't deselect broken tests
RESTRICT="test"

RDEPEND="dev-nim/httpbeast"
DEPEND="
	test? (
		${RDEPEND}
		dev-nim/asynctools
	)
"

DOCS=( {changelog,readme,todo}.markdown )

set_package_url "https://github.com/dom96/jester"

src_prepare() {
	default

	sed "s|https://github.com/timotheecour/\(asynctools\)|\1|g" \
		-i *.nimble || die
	use test || nimble_comment_requires asynctools

	sed "s/nimble \(c --hints:off\) -y/nim \1/g" -i tests/tester.nim || die
}

src_test() {
	enim r tests/tester
}
