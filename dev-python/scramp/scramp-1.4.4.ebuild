# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A pure-Python implementation of the SCRAM authentication protocol."
HOMEPAGE="
	https://pypi.org/project/scramp/
	https://github.com/tlocke/scramp
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/asn1crypto-1.4.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/passlib[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
