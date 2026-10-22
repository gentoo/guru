# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=uv-build

inherit distutils-r1 optfeature

DESCRIPTION="Type-safe Pydantic Schemas for Django JSONFields"
HOMEPAGE="
	https://github.com/surenkov/django-pydantic-field
	https://pypi.org/project/django-pydantic-field/
"
SRC_URI="https://github.com/surenkov/django-pydantic-field/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pydantic-1.10[${PYTHON_USEDEP}]
	>=dev-python/django-3.1[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		${RDEPEND}
		dev-python/uritemplate[${PYTHON_USEDEP}]
		dev-python/inflection[${PYTHON_USEDEP}]
		>=dev-python/dj-database-url-2.0[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/annotated-types[${PYTHON_USEDEP}]
		>=dev-python/djangorestframework-3.18.3[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-django syrupy )
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "openapi" "dev-python/uritemplate dev-python/inflection"
	# not packaged
	#optfeature "jsonform" ">=dev-python/django-jsonform-2.0"
}
