# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Update notifications for your CLI app"
HOMEPAGE="
	https://github.com/yeoman/update-notifier
	https://www.npmjs.com/package/update-notifier
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/boxen
	dev-node/chalk
	dev-node/configstore
	dev-node/has-yarn
	dev-node/import-lazy
	dev-node/is-ci
	dev-node/is-installed-globally
	dev-node/is-npm
	dev-node/is-yarn-global
	dev-node/latest-version
	dev-node/pupa
	dev-node/semver
	dev-node/semver-diff
	dev-node/xdg-basedir
"
