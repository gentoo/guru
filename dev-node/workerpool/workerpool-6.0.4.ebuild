# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Offload tasks to a pool of workers on node.js and in the browser"
HOMEPAGE="
	https://github.com/josdejong/workerpool
	https://www.npmjs.com/package/workerpool
"
SRC_URI="https://registry.npmjs.org/workerpool/-/workerpool-6.0.4.tgz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
