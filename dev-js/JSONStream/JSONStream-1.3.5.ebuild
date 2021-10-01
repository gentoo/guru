# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="rawStream.pipe(JSONStream.parse()).pipe(streamOfObjects)"
HOMEPAGE="
	https://github.com/dominictarr/JSONStream
	https://www.npmjs.com/package/JSONStream
"

LICENSE="|| ( MIT Apache-2.0 )"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/jsonparse
	dev-js/through
"
