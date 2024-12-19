# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="Collection of 60+ Python functions for validating data"
HOMEPAGE="
	https://github.com/insightindustry/validator-collection
	https://pypi.org/project/validator-collection
"
SRC_URI="https://github.com/insightindustry/${PN}/archive/refs/tags/v.${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-v.${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/jsonschema[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/pyfakefs[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	# Errors, probably because of missing privileges or problems in the virtual file system used in the tests
	"tests/test_checkers.py::test_is_readable[/var/data/xx1.txt-True-False]"
	"tests/test_validators.py::test_readable[/var/data/xx1.txt-True-False]"
	"tests/test_validators.py::test_writeable[/var/data/xx1.txt-True-False]"
	"tests/test_validators.py::test_executable[/var/data/xx1.txt-True-False]"
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme \
	dev-python/sphinx-tabs
