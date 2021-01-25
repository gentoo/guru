# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Tiny millisecond conversion utility"
HOMEPAGE="
	https://github.com/vercel/ms
	https://www.npmjs.com/package/ms
"
SRC_URI="https://registry.npmjs.org/ms/-/ms-2.1.3.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
