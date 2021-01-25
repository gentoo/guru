# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Minimal async jobs utility library, with streams support"
HOMEPAGE="
	https://github.com/alexindigo/asynckit
	https://www.npmjs.com/package/asynckit
"
SRC_URI="https://registry.npmjs.org/asynckit/-/asynckit-0.4.0.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
