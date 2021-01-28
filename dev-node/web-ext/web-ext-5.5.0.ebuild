# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A command line tool to help build, run, and test web extensions"
HOMEPAGE="
	https://github.com/mozilla/web-ext
	https://www.npmjs.com/package/web-ext
"

LICENSE="MPL-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/babel+polyfill
	dev-node/babel+runtime
	dev-node/cliqz-oss+firefox-client
	dev-node/cliqz-oss+node-firefox-connect
	dev-node/devicefarmer+adbkit
	dev-node/addons-linter
	dev-node/bunyan
	dev-node/camelcase
	dev-node/chrome-launcher
	dev-node/debounce
	dev-node/decamelize
	dev-node/es6-error
	dev-node/event-to-promise
	dev-node/firefox-profile
	dev-node/fs-extra
	dev-node/fx-runner
	dev-node/import-fresh
	dev-node/mkdirp
	dev-node/multimatch
	dev-node/mz
	dev-node/node-notifier
	dev-node/open
	dev-node/parse-json
	dev-node/sign-addon
	dev-node/source-map-support
	dev-node/strip-bom
	dev-node/strip-json-comments
	dev-node/tmp
	dev-node/update-notifier
	dev-node/watchpack
	dev-node/ws
	dev-node/yargs
	dev-node/zip-dir
"
