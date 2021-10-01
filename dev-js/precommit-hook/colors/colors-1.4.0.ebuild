# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="get colors in your node.js console"
HOMEPAGE="
	https://github.com/Marak/colors.js
	https://www.npmjs.com/package/colors
"
LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="examples"

src_install() {
	use examples && dodoc -r examples
	rm -rf examples || die
	node_src_install
}
