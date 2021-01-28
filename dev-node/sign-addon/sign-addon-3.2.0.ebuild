# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Signs a Firefox add-on using Mozilla's web service"
HOMEPAGE="
	https://github.com/mozilla/sign-addon
	https://www.npmjs.com/package/sign-addon
"

LICENSE="MPL-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/common-tags
	dev-node/core-js
	dev-node/deepcopy
	dev-node/es6-error
	dev-node/es6-promisify
	dev-node/jsonwebtoken
	dev-node/mz
	dev-node/request
	dev-node/source-map-support
	dev-node/stream-to-promise
"
