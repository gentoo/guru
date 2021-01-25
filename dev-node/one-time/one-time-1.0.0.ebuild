# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Run the supplied function exactly one time (once)"
HOMEPAGE="
	https://github.com/3rd-Eden/one-time
	https://www.npmjs.com/package/one-time
"
SRC_URI="https://registry.npmjs.org/one-time/-/one-time-1.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/fn_name
"
