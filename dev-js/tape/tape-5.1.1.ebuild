# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="tap-producing test harness for node and browsers"
HOMEPAGE="
	https://github.com/substack/tape
	https://www.npmjs.com/package/tape
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/call-bind
	dev-js/deep-equal
	dev-js/defined
	dev-js/dotignore
	dev-js/for-each
	dev-js/glob
	dev-js/has
	dev-js/inherits
	dev-js/is-regex
	dev-js/minimist
	dev-js/object-inspect
	dev-js/object-is
	dev-js/object_assign
	dev-js/resolve
	dev-js/resumer
	dev-js/string_prototype_trim
	dev-js/through
"
