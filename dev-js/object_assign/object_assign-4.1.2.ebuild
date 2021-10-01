# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ES6 spec-compliant Object.assign shim. From https://github.com/es-shims/es6-shim"
HOMEPAGE="
	https://github.com/ljharb/object.assign
	https://www.npmjs.com/package/object.assign
"

MYPN="${PN//_/.}"
SRC_URI="mirror://npm/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/call-bind
	dev-js/define-properties
	dev-js/has-symbols
	dev-js/object-keys
"
