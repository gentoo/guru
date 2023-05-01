# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A versatile test fixtures replacement based on thoughtbot's factory_bot for Ruby"
HOMEPAGE="
	https://pypi.org/project/factory-boy/
	https://github.com/FactoryBoy/factory_boy
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/Faker[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/django[sqlite,${PYTHON_USEDEP}]
		dev-python/pillow[jpeg,${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# depends on treecleaned dev-python/mongoengine
	tests/test_mongoengine.py
)

EPYTEST_DESELECT=(
	# broken
	examples/flask_alchemy
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme \
	dev-python/sphinxcontrib-spelling
