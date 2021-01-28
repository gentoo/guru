# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Parse JSON with more helpful errors"
HOMEPAGE="
	https://github.com/sindresorhus/parse-json
	https://www.npmjs.com/package/parse-json
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/babel+code-frame
	dev-node/error-ex
	dev-node/json-parse-even-better-errors
	dev-node/lines-and-columns
"
