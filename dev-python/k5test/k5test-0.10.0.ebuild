# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="A library for setting up self-contained Kerberos 5 environments"
HOMEPAGE="https://github.com/pythongssapi/k5test"
SRC_URI="https://github.com/pythongssapi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="
	${DEPEND}
	virtual/krb5
"
