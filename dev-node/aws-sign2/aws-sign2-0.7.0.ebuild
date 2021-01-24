# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="AWS signing. Originally pulled from LearnBoost/knox, maintained as vendor in request, now a standalone module."
HOMEPAGE="
	https://github.com/mikeal/aws-sign
	https://www.npmjs.com/package/aws-sign2
"
SRC_URI="https://registry.npmjs.org/aws-sign2/-/aws-sign2-0.7.0.tgz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
