# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Browser-friendly inheritance fully compatible with standard node.js inherits()"
HOMEPAGE="
	https://github.com/isaacs/inherits
	https://www.npmjs.com/package/inherits
"
SRC_URI="https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
