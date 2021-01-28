# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get the diff type of two semver versions"
HOMEPAGE="
	https://github.com/sindresorhus/semver-diff
	https://www.npmjs.com/package/semver-diff
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/semver
"
