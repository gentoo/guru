# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_10 )
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

python_prepare_all() {
	# do not install LICENSE and README to /usr/
	sed -i -e '/data_files/d' setup.py || die

	distutils-r1_python_prepare_all
}

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
