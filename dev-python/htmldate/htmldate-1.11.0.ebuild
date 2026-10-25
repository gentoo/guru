# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Fast and robust date extraction from web pages"
HOMEPAGE="https://github.com/adbar/htmldate"
SRC_URI="https://github.com/adbar/htmldate/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/dateparser[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

EPYTEST_DESELECT=(
	"tests/realworld_tests.py::test_readme_examples"
	"tests/unit_tests.py::test_cli"
	"tests/unit_tests.py::test_download"
	"tests/unit_tests.py::test_external_date_parser"
	"tests/unit_tests.py::test_input"
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
