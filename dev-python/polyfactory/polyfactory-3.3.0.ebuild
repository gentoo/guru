# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
PYPI_VERIFY_REPO=https://github.com/litestar-org/polyfactory
inherit distutils-r1 pypi

DESCRIPTION="Simple and powerful factories for mock data generation"
HOMEPAGE="
	https://github.com/litestar-org/polyfactory/
	https://pypi.org/project/polyfactory/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/faker-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/aiosqlite[${PYTHON_USEDEP}]
		>=dev-python/annotated-types-0.5.0[${PYTHON_USEDEP}]
		>=dev-python/attrs-22.2.0[${PYTHON_USEDEP}]
		dev-python/email-validator[${PYTHON_USEDEP}]
		>=dev-python/eval-type-backport-0.2.2[${PYTHON_USEDEP}]
		>=dev-python/greenlet-1[${PYTHON_USEDEP}]
		>=dev-python/hypothesis-6.86.2[${PYTHON_USEDEP}]
		>=dev-python/msgspec-0.20.0[${PYTHON_USEDEP}]
		>=dev-python/pydantic-1.10[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.4.29[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# required unpackaged beanie
	tests/test_beanie_factory.py
	# requires unpackaged odmantic
	tests/test_odmantic_factory.py
)
EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

python_test() {
	epytest tests
}
