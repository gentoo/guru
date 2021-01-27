# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="High-performance 2D spatial index for rectangles (based on R*-tree with bulk loading and bulk insertion algorithms)"
HOMEPAGE="
	https://github.com/mourner/rbush
	https://www.npmjs.com/package/rbush
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/quickselect
"