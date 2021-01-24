# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Normalize slashes in a file path to be posix/unix-like forward slashes. Also condenses repeat slashes to a single slash and removes and trailing slashes, unless disabled."
HOMEPAGE="
	https://github.com/jonschlinkert/normalize-path
	https://www.npmjs.com/package/normalize-path
"
SRC_URI="https://registry.npmjs.org/normalize-path/-/normalize-path-3.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
