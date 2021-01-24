# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Cyclist is an efficient cyclic list implemention."
HOMEPAGE="
	https://github.com/mafintosh/cyclist
	https://www.npmjs.com/package/cyclist
"
SRC_URI="https://registry.npmjs.org/cyclist/-/cyclist-1.0.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
