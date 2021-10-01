# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="deterministic JSON.stringify() - a faster version of substack's json-stable-strigify without jsonify"
HOMEPAGE="
	https://github.com/epoberezkin/fast-json-stable-stringify
	https://www.npmjs.com/package/fast-json-stable-stringify
"

LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="examples"

src_install() {
	use examples && dodoc -r example*
	rm -rf example* || die
	node_src_install
}
