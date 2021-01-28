# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Easy error subclassing and stack customization"
HOMEPAGE="
	https://github.com/qix-/node-error-ex
	https://www.npmjs.com/package/error-ex
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-arrayish
"
