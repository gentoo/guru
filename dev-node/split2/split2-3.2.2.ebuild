# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="split a Text Stream into a Line Stream, using Stream 3"
HOMEPAGE="
	https://github.com/mcollina/split2
	https://www.npmjs.com/package/split2
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/readable-stream
"
