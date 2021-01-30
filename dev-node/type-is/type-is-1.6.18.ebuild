# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Infer the content-type of a request."
HOMEPAGE="
	https://github.com/jshttp/type-is
	https://www.npmjs.com/package/type-is
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/media-typer
	dev-node/mime-types
"
