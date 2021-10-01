# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Which kind of boxed JS primitive is this?"
HOMEPAGE="
	https://github.com/inspect-js/which-boxed-primitive
	https://www.npmjs.com/package/which-boxed-primitive
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/is-bigint
	dev-js/is-boolean-object
	dev-js/is-number-object
	dev-js/is-string
	dev-js/is-symbol
"
