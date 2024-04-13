# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="fire"
inherit distutils-r1 pypi

DESCRIPTION="Library for automatically generating command line interfaces from Python objects"
HOMEPAGE="https://pypi.org/project/python-fire/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/six
	dev-python/termcolor
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/hypothesis
		dev-python/mock
		dev-python/pytest-asyncio
	)
"

distutils_enable_tests pytest
