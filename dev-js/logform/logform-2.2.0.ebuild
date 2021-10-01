# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="An mutable object-based log format designed for chaining & objectMode streams."
HOMEPAGE="
	https://github.com/winstonjs/logform
	https://www.npmjs.com/package/logform
"
LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="examples"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/colors
	dev-js/fast-safe-stringify
	dev-js/fecha
	dev-js/ms
	dev-js/triple-beam
"

src_install() {
	use examples && dodoc -r examples
	rm -rf examples || die
	node_src_install
}
