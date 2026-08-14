# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
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
		dev-python/termcolor
		dev-python/hypothesis
	)
"

EPYTEST_PLUGINS=(  )
EPYTEST_DESELECT=( "fire/fire_test.py::FireTest::testFireAsyncio" )

src_prepare() {
	default
	# Update / remove deprecated options
	sed -ie "/'License ::/d" setup.py \
		|| die "Failed to remove deprecated setuptools options"

	sed -ie "s/requires_python/python_requires/g" setup.py \
		|| die "Failed to rename deprecated `requires_python`"

	sed -ie "/tests_require/d" setup.py \
		|| die "Failed to remove deprecated `tests_require`"
}

distutils_enable_tests pytest
