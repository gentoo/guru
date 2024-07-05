# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Tailwind CSS Framework for Django projects"
HOMEPAGE="
	https://github.com/timonweb/django-tailwind
	https://pypi.org/project/django-tailwind/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-browser-reload[${PYTHON_USEDEP}]
"
