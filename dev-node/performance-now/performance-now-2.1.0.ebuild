# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Implements performance.now (based on process.hrtime)."
HOMEPAGE="
	https://github.com/braveg1rl/performance-now
	https://www.npmjs.com/package/performance-now
"
SRC_URI="https://registry.npmjs.org/performance-now/-/performance-now-2.1.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
