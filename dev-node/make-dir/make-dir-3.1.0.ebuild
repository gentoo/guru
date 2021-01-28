# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Make a directory and its parents if needed - Think mkdir -p"
HOMEPAGE="
	https://github.com/sindresorhus/make-dir
	https://www.npmjs.com/package/make-dir
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/semver
"
