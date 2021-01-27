# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A through2 wrapper that just receives chunks and nothing else."
HOMEPAGE="
	https://github.com/joepie91/through2-sink
	https://www.npmjs.com/package/through2-sink
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/through2
	dev-node/xtend
"