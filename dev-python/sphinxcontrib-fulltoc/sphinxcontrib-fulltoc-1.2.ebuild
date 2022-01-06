# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="python-dbus-next is a Python library for DBus"
HOMEPAGE="
	https://github.com/sphinx-contrib/fulltoc
	https://pypi.org/project/sphinxcontrib-fulltoc
	https://sphinxcontrib-fulltoc.readthedocs.io
"
SRC_URI="https://github.com/sphinx-contrib/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND="dev-python/pbr[${PYTHON_USEDEP}]"

export OSLO_PACKAGE_VERSION=${PV}

S="${WORKDIR}/fulltoc-${PV}"

distutils_enable_tests setup.py

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*.pth' -delete || die
}
