# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="Python library of 60+ commonly-used validator functions."
HOMEPAGE="https://github.com/insightindustry/validator-collection https://pypi.org/project/validator-collection"
SRC_URI="https://github.com/insightindustry/validator-collection/archive/refs/tags/v.${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-v.${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

BDEPEND="
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/sphinx-tabs[${PYTHON_USEDEP}]
	dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/codecov[${PYTHON_USEDEP}]
		dev-python/pyfakefs[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

EPYTEST_DESELECT=(
	# Errors, probably because of missing privileges or problems in the virtual file system used in the tests
	"tests/test_checkers.py::test_is_readable[/var/data/xx1.txt-True-False]"
	"tests/test_validators.py::test_readable[/var/data/xx1.txt-True-False]"
	"tests/test_validators.py::test_writeable[/var/data/xx1.txt-True-False]"
	"tests/test_validators.py::test_executable[/var/data/xx1.txt-True-False]"
)

distutils_enable_tests pytest
distutils_enable_sphinx docs
