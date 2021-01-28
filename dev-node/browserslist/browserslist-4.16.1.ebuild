# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Share target browsers between different front-end tools, like Autoprefixer, Stylelint and babel-env-preset"
HOMEPAGE="
	https://github.com/browserslist/browserslist
	https://www.npmjs.com/package/browserslist
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/caniuse-lite
	dev-node/colorette
	dev-node/electron-to-chromium
	dev-node/escalade
	dev-node/node-releases
"
