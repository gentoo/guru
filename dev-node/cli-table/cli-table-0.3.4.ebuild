# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Pretty unicode tables for the CLI"
HOMEPAGE="
	https://github.com/Automattic/cli-table
	https://www.npmjs.com/package/cli-table
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/chalk
	dev-node/string-width
"
