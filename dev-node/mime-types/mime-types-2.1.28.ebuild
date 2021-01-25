# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="The ultimate javascript content-type utility."
HOMEPAGE="
	https://github.com/jshttp/mime-types
	https://www.npmjs.com/package/mime-types
"
SRC_URI="https://registry.npmjs.org/mime-types/-/mime-types-2.1.28.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/mime-db
"
