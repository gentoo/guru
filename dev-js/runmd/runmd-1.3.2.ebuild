# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Runnable README files"
HOMEPAGE="
	https://github.com/broofa/runmd
	https://www.npmjs.com/package/runmd
"
SRC_URI="https://github.com/broofa/runmd/archive/refs/tags/v${PV}.tar.gz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/minimist
	dev-js/require-like
"
S="${WORKDIR}/${P}"
