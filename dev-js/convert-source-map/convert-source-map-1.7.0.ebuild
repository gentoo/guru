# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Converts a source-map from/to  different formats and allows adding/changing properties."
HOMEPAGE="
	https://github.com/thlorenz/convert-source-map
	https://www.npmjs.com/package/convert-source-map
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/safe-buffer
"
