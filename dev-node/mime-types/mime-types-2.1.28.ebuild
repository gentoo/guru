# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The ultimate javascript content-type utility."
HOMEPAGE="
	https://github.com/jshttp/mime-types
	https://www.npmjs.com/package/mime-types
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/mime-db
"