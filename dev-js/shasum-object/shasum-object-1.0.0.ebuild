# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="get the shasum of a buffer or object"
HOMEPAGE="
	https://github.com/goto-bus-stop/shasum-object
	https://www.npmjs.com/package/shasum-object
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/fast-safe-stringify
"
