# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="fs-extra contains methods that aren't included in the vanilla Node.js fs package. Such as recursive mkdir, copy, and remove."
HOMEPAGE="
	https://github.com/jprichardson/node-fs-extra
	https://www.npmjs.com/package/fs-extra
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/at-least-node
	dev-node/graceful-fs
	dev-node/jsonfile
	dev-node/universalify
"
