# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Tiny queue data structure"
HOMEPAGE="
	https://github.com/sindresorhus/yocto-queue
	https://www.npmjs.com/package/yocto-queue
"
SRC_URI="https://registry.npmjs.org/yocto-queue/-/yocto-queue-0.1.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
