# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Run a function exactly one time"
HOMEPAGE="
	https://github.com/isaacs/once
	https://www.npmjs.com/package/once
"
SRC_URI="https://registry.npmjs.org/once/-/once-1.4.0.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/wrappy
"
