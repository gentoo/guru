# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="resolve like require.resolve() on behalf of files asynchronously and synchronously"
HOMEPAGE="
	https://github.com/browserify/resolve
	https://www.npmjs.com/package/resolve
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/is-core-module
	dev-js/path-parse
"
IUSE="examples"

src_install() {
	use examples && dodoc -r example
	rm -rf example || die
	node_src_install
}
