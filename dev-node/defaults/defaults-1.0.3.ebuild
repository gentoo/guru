# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="merge single level defaults over a config object"
HOMEPAGE="
	https://github.com/tmpvar/defaults
	https://www.npmjs.com/package/defaults
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/clone
"
