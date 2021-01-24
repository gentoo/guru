# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Yet Another Linked List"
HOMEPAGE="
	https://github.com/isaacs/yallist
	https://www.npmjs.com/package/yallist
"
SRC_URI="https://registry.npmjs.org/yallist/-/yallist-4.0.0.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
