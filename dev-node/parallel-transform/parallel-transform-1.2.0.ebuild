# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Transform stream that allows you to run your transforms in parallel without changing the order"
HOMEPAGE="
	https://github.com/mafintosh/parallel-transform
	https://www.npmjs.com/package/parallel-transform
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/cyclist
	dev-node/inherits
	dev-node/readable-stream
"