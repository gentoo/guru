# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="create, parse and reply to messages of the Jupyter Messaging Protocol"
HOMEPAGE="
	https://github.com/n-riesco/jmp
	https://www.npmjs.com/package/jmp
"

LICENSE="BSD"
KEYWORDS="~amd64"
PATCHES=( "${FILESDIR}/uuid.patch" )
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/uuid
	dev-js/zeromq
"
