# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

MYPV="3.0.0-1"
MYP="${PN}-${MYPV}"
SRC_URI="https://registry.npmjs.org/${PN}/-/${MYP}.tgz"
DESCRIPTION="Fast implementation of JSON-Patch (RFC-6902) with duplex (observe changes) capabilities"
HOMEPAGE="
	https://github.com/Starcounter-Jack/JSON-Patch
	https://www.npmjs.com/package/fast-json-patch
"

LICENSE="MIT"
KEYWORDS="~amd64"
