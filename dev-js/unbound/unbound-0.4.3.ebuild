# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Bindings to libunbound for node.js"
HOMEPAGE="
	https://github.com/chjj/unbound
	https://www.npmjs.com/package/unbound
"

LICENSE="MIT"
KEYWORDS="~amd64"

DEPEND="
	${NODEJS_DEPEND}
	net-dns/unbound
"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/loady
	net-dns/unbound
"
