# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Bash-like brace expansion, implemented in JavaScript. Safer than other brace expansion libs, with complete support for the Bash 4.3 braces specification, without sacrificing speed."
HOMEPAGE="
	https://github.com/micromatch/braces
	https://www.npmjs.com/package/braces
"
SRC_URI="https://registry.npmjs.org/braces/-/braces-3.0.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/fill-range
"
