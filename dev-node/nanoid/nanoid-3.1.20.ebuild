# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="A tiny (108 bytes), secure URL-friendly unique string ID generator"
HOMEPAGE="
	https://github.com/ai/nanoid
	https://www.npmjs.com/package/nanoid
"
SRC_URI="https://registry.npmjs.org/nanoid/-/nanoid-3.1.20.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
