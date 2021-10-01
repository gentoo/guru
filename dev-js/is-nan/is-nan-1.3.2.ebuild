# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ES2015-compliant shim for Number.isNaN - the global isNaN returns false positives."
HOMEPAGE="
	https://github.com/es-shims/is-nan
	https://www.npmjs.com/package/is-nan
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/call-bind
	dev-js/define-properties
"
