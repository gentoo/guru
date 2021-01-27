# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Proxies nodejs require in order to allow overriding dependencies during testing."
HOMEPAGE="
	https://github.com/thlorenz/proxyquire
	https://www.npmjs.com/package/proxyquire
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/fill-keys
	dev-node/module-not-found-error
	dev-node/resolve
"
