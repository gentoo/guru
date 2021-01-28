# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Check if the process is running inside Windows Subsystem for Linux (Bash on Windows)"
HOMEPAGE="
	https://github.com/sindresorhus/is-wsl
	https://www.npmjs.com/package/is-wsl
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-docker
"
