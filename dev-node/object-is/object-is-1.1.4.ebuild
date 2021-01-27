# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ES2015-compliant shim for Object.is - differentiates between -0 and +0"
HOMEPAGE="
	https://github.com/es-shims/object-is
	https://www.npmjs.com/package/object-is
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/call-bind
	dev-node/define-properties
"
