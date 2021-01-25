# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="A through2 wrapper that just receives chunks and nothing else."
HOMEPAGE="
	https://github.com/joepie91/through2-sink
	https://www.npmjs.com/package/through2-sink
"
SRC_URI="https://registry.npmjs.org/through2-sink/-/through2-sink-1.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/through2
	dev-node/xtend
"
