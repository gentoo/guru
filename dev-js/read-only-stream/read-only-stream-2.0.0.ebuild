# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="wrap a readable/writable stream to be read-only"
HOMEPAGE="
	https://github.com/substack/read-only-stream
	https://www.npmjs.com/package/read-only-stream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/readable-stream
"
