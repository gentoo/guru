# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="elegant & feature rich browser / node HTTP with a fluent API"
HOMEPAGE="
	https://github.com/visionmedia/superagent
	https://www.npmjs.com/package/superagent
"
SRC_URI="https://registry.npmjs.org/superagent/-/superagent-6.1.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/component-emitter
	dev-node/cookiejar
	dev-node/debug
	dev-node/fast-safe-stringify
	dev-node/form-data
	dev-node/formidable
	dev-node/methods
	dev-node/mime
	dev-node/qs
	dev-node/readable-stream
	dev-node/semver
"
