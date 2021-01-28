# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="super fast, all natural json logger"
HOMEPAGE="
	http://getpino.io
	https://www.npmjs.com/package/pino
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/fast-redact
	dev-node/fast-safe-stringify
	dev-node/flatstr
	dev-node/pino-std-serializers
	dev-node/quick-format-unescaped
	dev-node/sonic-boom
"
