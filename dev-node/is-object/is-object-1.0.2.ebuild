# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Checks whether a value is an object"
HOMEPAGE="
	https://github.com/inspect-js/is-object
	https://www.npmjs.com/package/is-object
"
SRC_URI="https://registry.npmjs.org/is-object/-/is-object-1.0.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
