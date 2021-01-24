# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A high-performance JavaScript 2D/3D polyline simplification library"
HOMEPAGE="
	http://mourner.github.com/simplify-js/
	https://www.npmjs.com/package/simplify-js
"
SRC_URI="https://registry.npmjs.org/simplify-js/-/simplify-js-1.2.4.tgz"
LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
