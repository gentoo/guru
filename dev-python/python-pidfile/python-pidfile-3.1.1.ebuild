# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="PIDFile context processor. Supported py2 and py3"
HOMEPAGE="https://github.com/mosquito/python-pidfile"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test" # https://github.com/mosquito/python-pidfile/issues/7

RDEPEND="
	dev-python/psutil[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest

python_test() {
	eunittest tests/
}
