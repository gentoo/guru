# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Easily generate random strings of various types"
HOMEPAGE="
	https://github.com/leapfrogonline/rstr
	https://pypi.org/project/rstr/
"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"

distutils_enable_tests unittest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
