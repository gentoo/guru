# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Check if a value is a plain object"
HOMEPAGE="
	https://github.com/sindresorhus/is-plain-obj
	https://www.npmjs.com/package/is-plain-obj
"
SRC_URI="https://registry.npmjs.org/is-plain-obj/-/is-plain-obj-3.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
