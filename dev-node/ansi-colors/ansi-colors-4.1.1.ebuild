# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Easily add ANSI colors to your text and symbols in the terminal. A faster drop-in replacement for chalk, kleur and turbocolor (without the dependencies and rendering bugs)."
HOMEPAGE="
	https://github.com/doowb/ansi-colors
	https://www.npmjs.com/package/ansi-colors
"
SRC_URI="https://registry.npmjs.org/ansi-colors/-/ansi-colors-4.1.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
