# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A Node.js module for sending notifications on native Mac, Windows (post and pre 8) and Linux (or Growl as fallback)"
HOMEPAGE="
	https://github.com/mikaelbr/node-notifier
	https://www.npmjs.com/package/node-notifier
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/growly
	dev-node/is-wsl
	dev-node/semver
	dev-node/shellwords
	dev-node/uuid
	dev-node/which
"
