# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="IJavascript is a Javascript kernel for the Jupyter notebook"
HOMEPAGE="
	https://n-riesco.github.io/ijavascript
	https://www.npmjs.com/package/ijavascript
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/jp-kernel
"
