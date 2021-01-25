# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

first="${PN%%+*}"
second="${PN#*+}"
SRC_URI="https://registry.npmjs.org/@${first}/${second}/-/${second}.tgz -> ${P}.tgz"
DESCRIPTION="Tools for debugging your node.js modules and event loop"
HOMEPAGE="
	https://github.com/3rd-Eden/diagnostics
	https://www.npmjs.com/package/@dabh/diagnostics
"
LICENSE="MIT"
KEYWORDS="~amd64"