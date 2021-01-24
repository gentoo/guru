# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A robust Punycode converter that fully complies to RFC 3492 and RFC 5891, and works on nearly all JavaScript platforms."
HOMEPAGE="
	https://mths.be/punycode
	https://www.npmjs.com/package/punycode
"
SRC_URI="https://registry.npmjs.org/punycode/-/punycode-2.1.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
