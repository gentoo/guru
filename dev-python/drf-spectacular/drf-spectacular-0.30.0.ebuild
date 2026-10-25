# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Sane and flexible OpenAPI 3 schema generation for Django REST framework"
HOMEPAGE="
	https://github.com/tfranzel/drf-spectacular
	https://pypi.org/project/drf-spectacular/
"
SRC_URI="https://github.com/tfranzel/drf-spectacular/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

PATCHES=( "${FILESDIR}"/0.30.0-fix-tests.patch )

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/django-2.2[${PYTHON_USEDEP}]
	>=dev-python/djangorestframework-3.10.3[${PYTHON_USEDEP}]
	>=dev-python/uritemplate-4.2.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/inflection-0.3.1[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		${RDEPEND}
		>=dev-python/uritemplate-4.2.0[${PYTHON_USEDEP}]
		>=dev-python/inflection-0.5.1-r1[${PYTHON_USEDEP}]
		>=dev-python/dj-database-url-2.0[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
		>=dev-python/annotated-types-0.8.0[${PYTHON_USEDEP}]
		>=dev-python/psycopg-3.3.6[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-django pytest-cov )
distutils_enable_tests pytest

python_test() {
	# django-oauth-toolkit is not packaged
	# djangorestframework-recursive is not packaged
	PYTHONPATH=. "${EPYTHON}" runtests.py \
		--nolint \
		--skip-missing-contrib \
		--ignore "tests/contrib/test_oauth_toolkit.py" \
		--ignore "tests/contrib/test_rest_framework_recursive.py" \
		|| die "Tests failed with ${EPYTHON}"
}
