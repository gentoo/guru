# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12})
inherit distutils-r1

DESCRIPTION="Framework API development with Flask"
HOMEPAGE="https://flask-restx.readthedocs.io"
SRC_URI="https://github.com/python-restx/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

PATCHES=( "${FILESDIR}/${PN}-fix-flask-compat.patch" )

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
		dev-python/Faker[${PYTHON_USEDEP}]
		dev-python/pytest-flask[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/tzlocal[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	skip_tests=" \
		not ReqParseTest and \
		not EmailTest and \
		not URLTest and \
		not LoggingTest"

	epytest tests/test_*.py -k "${skip_tests}"
}
