# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="SHA-256 Hashes of popular JS libraries, used by Mozilla's Add-ons Linter"
HOMEPAGE="
	https://github.com/mozilla/dispensary
	https://www.npmjs.com/package/dispensary
"

LICENSE="MPL-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/async
	dev-node/natural-compare-lite
	dev-node/pino
	dev-node/request
	dev-node/sha_js
	dev-node/source-map-support
	dev-node/yargs
"
