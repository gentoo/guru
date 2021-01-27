# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Generic Node.js kernel for the Jupyter notebook"
HOMEPAGE="
	https://n-riesco.github.io/jp-kernel
	https://www.npmjs.com/package/jp-kernel
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/jmp
	dev-node/nel
	dev-node/uuid
"
