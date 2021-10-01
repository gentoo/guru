# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="quote and parse shell commands"
HOMEPAGE="
	https://github.com/substack/node-shell-quote
	https://www.npmjs.com/package/shell-quote
"

LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="examples"

src_install() {
	use examples && dodoc -r example
	rm -rf example || die
	node_src_install
}
