# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Django OpenID Connect library"
HOMEPAGE="
	https://github.com/mozilla/mozilla-django-oidc
	https://pypi.org/project/mozilla-django-oidc/"
SRC_URI="https://github.com/mozilla/mozilla-django-oidc/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/django-4.2[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]"

BDEPEND="
	test? (
		${RDEPEND}
		>=dev-python/djangorestframework-3.14[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

python_test() {
	local -x DJANGO_SETTINGS_MODULE=tests.settings
	epytest
}
