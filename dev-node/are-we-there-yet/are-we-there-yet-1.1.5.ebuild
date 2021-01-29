# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Keep track of the overall completion of many disparate processes"
HOMEPAGE="
	https://github.com/iarna/are-we-there-yet
	https://www.npmjs.com/package/are-we-there-yet
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/delegates
	dev-node/readable-stream
"
