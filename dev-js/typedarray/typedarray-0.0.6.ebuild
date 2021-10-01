# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="TypedArray polyfill for old browsers"
HOMEPAGE="
	https://github.com/substack/typedarray
	https://www.npmjs.com/package/typedarray
"

LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="examples"

src_install() {
	use examples && dodoc -r example
	rm -rf example || die
	node_src_install
}
