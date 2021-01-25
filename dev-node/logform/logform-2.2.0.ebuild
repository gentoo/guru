# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="An mutable object-based log format designed for chaining & objectMode streams."
HOMEPAGE="
	https://github.com/winstonjs/logform
	https://www.npmjs.com/package/logform
"
SRC_URI="https://registry.npmjs.org/logform/-/logform-2.2.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/colors
	dev-node/fast-safe-stringify
	dev-node/fecha
	dev-node/ms
	dev-node/triple-beam
"
