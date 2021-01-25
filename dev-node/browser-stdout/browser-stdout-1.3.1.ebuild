# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="process.stdout in your browser"
HOMEPAGE="
	https://github.com/kumavis/browser-stdout
	https://www.npmjs.com/package/browser-stdout
"
SRC_URI="https://registry.npmjs.org/browser-stdout/-/browser-stdout-1.3.1.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
