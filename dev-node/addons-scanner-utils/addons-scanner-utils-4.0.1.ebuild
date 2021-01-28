# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Various addons related helpers to build CLIs."
HOMEPAGE="
	https://www.npmjs.com/package/addons-scanner-utils
"

LICENSE="MPL-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/types+yauzl
	dev-node/common-tags
	dev-node/first-chunk-stream
	dev-node/strip-bom-stream
	dev-node/upath
	dev-node/yauzl
"
