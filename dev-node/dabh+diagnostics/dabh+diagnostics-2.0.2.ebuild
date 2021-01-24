# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Tools for debugging your node.js modules and event loop"
HOMEPAGE="
	https://github.com/3rd-Eden/diagnostics
	https://www.npmjs.com/package/@dabh/diagnostics
"
SRC_URI="https://registry.npmjs.org/@dabh/diagnostics/-/diagnostics-2.0.2.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
