# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Open stuff like URLs, files, executables. Cross-platform."
HOMEPAGE="
	https://github.com/sindresorhus/open
	https://www.npmjs.com/package/open
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-docker
	dev-node/is-wsl
"
