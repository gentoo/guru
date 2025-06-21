# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12})
inherit distutils-r1

DESCRIPTION="Framework API development with Flask"
HOMEPAGE="https://flask-restx.readthedocs.io"
SRC_URI="https://github.com/python-restx/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	dev-python/aniso8601[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
	test? (
		dev-python/blinker[${PYTHON_USEDEP}]
		dev-python/faker[${PYTHON_USEDEP}]
		dev-python/pytest-flask[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/tzlocal[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${PN}-avoid-importlib_resources.patch" )

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	"tests/test_swagger.py::SwaggerTest::test_specs_endpoint_host_and_subdomain"
	"tests/test_fields.py::DatetimeFieldTest::test_iso8601_value"
	"tests/test_fields.py::DatetimeFieldTest::test_rfc822_value"
	"tests/test_inputs.py::URLTest::test_check"
	"tests/test_inputs.py::EmailTest::test_valid_value_check"
)

EPYTEST_IGNORE=(
	"tests/benchmarks/bench_marshalling.py"
	"tests/benchmarks/bench_swagger.py"
)
