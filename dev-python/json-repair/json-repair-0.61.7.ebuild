# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

MY_PN="json_repair"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A package to repair broken json strings"
HOMEPAGE="
	https://github.com/mangiucugna/json_repair
	https://pypi.org/project/json-repair/
"
SRC_URI="
	https://github.com/mangiucugna/${MY_PN}/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/${MY_P}/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# mypy is used in tests for type inference
BDEPEND="
	test? (
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/flask-cors[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/mypy[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# pytest-benchmark
	tests/test_performance.py
)
