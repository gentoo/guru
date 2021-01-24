# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Does exactly what you expects"
HOMEPAGE="
	https://github.com/vjeux/download-file-sync
	https://www.npmjs.com/package/download-file-sync
"
SRC_URI="https://registry.npmjs.org/download-file-sync/-/download-file-sync-1.0.4.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
