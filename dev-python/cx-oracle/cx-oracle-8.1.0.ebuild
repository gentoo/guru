# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

MY_PN="cx_Oracle"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python interface to Oracle"
HOMEPAGE="
	https://oracle.github.io/python-cx_Oracle/
	https://pypi.org/project/cx-Oracle/
"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="Computronix"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples"

DEPEND="dev-db/oracle-instantclient"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

pkg_postinst() {
	return
	# no python_mod_optimize
}

src_install() {
	distutils-r1_src_install
	if use examples; then
		docinto examples
		dodoc -r samples/. || die
	fi
}
