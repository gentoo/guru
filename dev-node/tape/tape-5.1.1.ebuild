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
	dev-node/call-bind
	dev-node/deep-equal
	dev-node/defined
	dev-node/dotignore
	dev-node/for-each
	dev-node/glob
	dev-node/has
	dev-node/inherits
	dev-node/is-regex
	dev-node/minimist
	dev-node/object-inspect
	dev-node/object-is
	dev-node/object_assign
	dev-node/resolve
	dev-node/resumer
	dev-node/string_prototype_trim
	dev-node/through
"
