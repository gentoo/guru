# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Recursively iterates over specified directory, require()'ing each file, and returning a nested hash structure containing those modules."
HOMEPAGE="
	https://github.com/troygoode/node-require-directory/
	https://www.npmjs.com/package/require-directory
"
SRC_URI="https://registry.npmjs.org/require-directory/-/require-directory-2.1.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
