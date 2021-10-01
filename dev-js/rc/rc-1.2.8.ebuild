# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="hardwired configuration loader"
HOMEPAGE="
	https://github.com/dominictarr/rc
	https://www.npmjs.com/package/rc
"

LICENSE="|| ( BSD-2 MIT Apache-2.0 )"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/deep-extend
	dev-js/ini
	dev-js/minimist
	dev-js/strip-json-comments
"
