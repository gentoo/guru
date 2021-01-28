# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Mozilla Add-ons Linter"
HOMEPAGE="
	https://github.com/mozilla/addons-linter
	https://www.npmjs.com/package/addons-linter
"

LICENSE="MPL-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/babel+runtime
	dev-node/mdn+browser-compat-data
	dev-node/addons-scanner-utils
	dev-node/ajv
	dev-node/ajv-merge-patch
	dev-node/chalk
	dev-node/cheerio
	dev-node/columnify
	dev-node/common-tags
	dev-node/deepmerge
	dev-node/dispensary
	dev-node/eslint
	dev-node/eslint-plugin-no-unsanitized
	dev-node/eslint-visitor-keys
	dev-node/espree
	dev-node/esprima
	dev-node/fluent-syntax
	dev-node/glob
	dev-node/is-mergeable-object
	dev-node/jed
	dev-node/os-locale
	dev-node/pino
	dev-node/postcss
	dev-node/probe-image-size
	dev-node/relaxed-json
	dev-node/semver
	dev-node/source-map-support
	dev-node/tosource
	dev-node/upath
	dev-node/yargs
	dev-node/yauzl
	dev-node/fsevents
"
