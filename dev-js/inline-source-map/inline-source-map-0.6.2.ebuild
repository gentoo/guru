# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Adds source mappings and base64 encodes them, so they can be inlined in your generated file."
HOMEPAGE="
	https://github.com/thlorenz/inline-source-map
	https://www.npmjs.com/package/inline-source-map
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/source-map
"
