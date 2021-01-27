# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A useful pre-commit hook for git based projects that lints and runs npm test"
HOMEPAGE="
	https://github.com/nlf/precommit-hook
	https://www.npmjs.com/package/precommit-hook
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/git-validate
	dev-node/jshint
"
