# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Make a callback- or promise-based function support both promises and callbacks."
HOMEPAGE="
	https://github.com/RyanZim/universalify
	https://www.npmjs.com/package/universalify
"
SRC_URI="https://registry.npmjs.org/universalify/-/universalify-2.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
