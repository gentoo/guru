# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Domain name parser based on the Public Suffix List"
HOMEPAGE="
	https://github.com/lupomontero/psl
	https://www.npmjs.com/package/psl
"
SRC_URI="https://registry.npmjs.org/psl/-/psl-1.8.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
