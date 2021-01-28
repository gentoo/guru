# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="CLI for webpack & friends"
HOMEPAGE="
	https://github.com/webpack/webpack-cli
	https://www.npmjs.com/package/webpack-cli
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/discoveryjs+json-ext
	dev-node/webpack-cli+configtest
	dev-node/webpack-cli+info
	dev-node/webpack-cli+serve
	dev-node/colorette
	dev-node/commander
	dev-node/enquirer
	dev-node/execa
	dev-node/fastest-levenshtein
	dev-node/import-local
	dev-node/interpret
	dev-node/rechoir
	dev-node/v8-compile-cache
	dev-node/webpack-merge
"
