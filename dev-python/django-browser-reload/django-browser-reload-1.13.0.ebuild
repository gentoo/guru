# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Automatically reload your browser in development"
HOMEPAGE="
	https://github.com/adamchainz/django-browser-reload
	https://pypi.org/project/django-browser-reload/
"
SRC_URI="https://github.com/adamchainz/django-browser-reload/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/pytest-django[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
