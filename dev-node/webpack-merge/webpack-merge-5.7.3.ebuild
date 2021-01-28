# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Variant of merge that's useful for webpack configuration"
HOMEPAGE="
	https://github.com/survivejs/webpack-merge
	https://www.npmjs.com/package/webpack-merge
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/clone-deep
	dev-node/wildcard
"
