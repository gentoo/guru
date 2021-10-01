# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="node's assert.deepEqual algorithm except for NaN being equal to NaN"
HOMEPAGE="
	https://github.com/thlorenz/deep-is
	https://www.npmjs.com/package/deep-is
"

LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="examples"

src_install() {
	use examples && dodoc -r example
	rm -rf example || die
	node_src_install
}
