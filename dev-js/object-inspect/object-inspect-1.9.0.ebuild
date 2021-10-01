# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="string representations of objects in node and the browser"
HOMEPAGE="
	https://github.com/inspect-js/object-inspect
	https://www.npmjs.com/package/object-inspect
"

LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="examples"

src_install() {
	use examples && dodoc -r example
	rm -rf example || die
	node_src_install
}
