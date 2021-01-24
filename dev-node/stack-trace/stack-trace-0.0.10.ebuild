# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Get v8 stack traces as an array of CallSite objects."
HOMEPAGE="
	https://github.com/felixge/node-stack-trace
	https://www.npmjs.com/package/stack-trace
"
SRC_URI="https://registry.npmjs.org/stack-trace/-/stack-trace-0.0.10.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
