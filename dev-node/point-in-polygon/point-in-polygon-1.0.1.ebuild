# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="determine if a point is inside a polygon with a ray intersection counting algorithm"
HOMEPAGE="
	https://github.com/substack/point-in-polygon
	https://www.npmjs.com/package/point-in-polygon
"
SRC_URI="https://registry.npmjs.org/point-in-polygon/-/point-in-polygon-1.0.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
