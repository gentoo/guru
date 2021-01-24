# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Transform stream that allows you to run your transforms in parallel without changing the order"
HOMEPAGE="
	https://github.com/mafintosh/parallel-transform
	https://www.npmjs.com/package/parallel-transform
"
SRC_URI="https://registry.npmjs.org/parallel-transform/-/parallel-transform-1.2.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/cyclist
	dev-node/inherits
	dev-node/readable-stream
"
