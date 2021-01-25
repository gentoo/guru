# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Check if a file path is a binary file"
HOMEPAGE="
	https://github.com/sindresorhus/is-binary-path
	https://www.npmjs.com/package/is-binary-path
"
SRC_URI="https://registry.npmjs.org/is-binary-path/-/is-binary-path-2.1.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/binary-extensions
"
