# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

NIA_COMMIT="a776a247bef10a61697530742d70c1c214ad2a78"
DESCRIPTION="A sinatra-like web framework for Nim"
HOMEPAGE="
	https://github.com/dom96/jester
	https://nimble.directory/pkg/jester
"
SRC_URI="
	https://github.com/dom96/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/dom96/nim-in-action-code/archive/${NIA_COMMIT}.tar.gz -> NIA-${NIA_COMMIT}.tar.gz )
"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-nim/httpbeast"
DEPEND="
	test? (
		${RDEPEND}
		dev-nim/asynctools
	)
"

PATCHES=( "${FILESDIR}"/${P}-remove-test.patch )

DOCS=( {changelog,readme,todo}.markdown )

set_package_url "https://github.com/dom96/jester"

src_unpack() {
	default

	if use test; then
		rmdir "${S}"/tests/nim-in-action-code || die
		mv "${WORKDIR}"/nim-in-action-code-${NIA_COMMIT} ${S}/tests/nim-in-action-code || die
	fi
}

src_prepare() {
	default

	sed "s/nimble \(c --hints:off\) -y/nim \1/g" -i tests/tester.nim || die
}

src_test() {
	enim r tests/tester
}
