# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A library for finding and using SSH public keys"
HOMEPAGE="
	https://github.com/arekinath/node-sshpk
	https://www.npmjs.com/package/sshpk
"
SRC_URI="https://registry.npmjs.org/sshpk/-/sshpk-1.16.1.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
