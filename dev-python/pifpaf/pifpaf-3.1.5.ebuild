# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_DESELECT=( pifpaf/tests/test_cli.py::TestCli::test_non_existing_command )
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 pypi

DESCRIPTION="Python fixtures and daemon managing tools for functional testing"
HOMEPAGE="
	https://pypi.org/project/pifpaf/
	https://github.com/jd/pifpaf
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/daiquiri[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/fixtures[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/xattr[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/pbr[${PYTHON_USEDEP}]
	test? (
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/testrepository[${PYTHON_USEDEP}]
		dev-python/testtools[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
