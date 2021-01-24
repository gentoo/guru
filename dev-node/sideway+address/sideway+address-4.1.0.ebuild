# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Email address and domain validation"
HOMEPAGE="
	https://github.com/sideway/address
	https://www.npmjs.com/package/@sideway/address
"
SRC_URI="https://registry.npmjs.org/@sideway/address/-/address-4.1.0.tgz -> ${P}.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/hapi+hoek
"
