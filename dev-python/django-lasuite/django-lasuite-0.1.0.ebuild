# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 optfeature pypi

DESCRIPTION="Common library for LaSuite Django projects"
HOMEPAGE="
	https://github.com/suitenumerique/django-lasuite
	https://pypi.org/project/django-lasuite/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# TODO
RESTRICT="test"

RDEPEND="
	>=dev-python/django-5[${PYTHON_USEDEP}]
	>=dev-python/djangorestframework-3.15.2[${PYTHON_USEDEP}]
	>=dev-python/mozilla-django-oidc-5[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.9.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32.3[${PYTHON_USEDEP}]
	>=dev-python/requests-toolbelt-1.0.0[${PYTHON_USEDEP}]
	dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

pkg_postinst() {
	optfeature "malware-detection" ">=dev-python/celery-5.0 >=dev-python/cryptography-42.0"
	optfeature "configuration" ">=dev-python/django-configurations-2.5.1"
}
