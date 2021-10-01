# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="determine if a point is inside a polygon with a ray intersection counting algorithm"
HOMEPAGE="
	https://github.com/substack/point-in-polygon
	https://www.npmjs.com/package/point-in-polygon
"
LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="examples"

src_install() {
	use examples && dodoc -r example
	rm -rf example || die
	node_src_install
}
