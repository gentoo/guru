# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..12} )
PYPI_PN="cx_Oracle"
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Python interface to Oracle"
HOMEPAGE="
	https://oracle.github.io/python-cx_Oracle/
	https://pypi.org/project/cx-Oracle/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples"

# Tests require local instance of Oracle DB
RESTRICT="test"

DEPEND="dev-db/oracle-instantclient"
RDEPEND="${DEPEND}"

src_prepare() {
	# do not install LICENSE and README to /usr/
	sed -i -e '/data_files/d' setup.py || die

	distutils-r1_src_prepare
}
