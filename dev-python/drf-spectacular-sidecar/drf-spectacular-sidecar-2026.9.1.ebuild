# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Serve self-contained distribution builds of Swagger UI and Redoc with Django"
HOMEPAGE="
	https://github.com/tfranzel/drf-spectacular-sidecar
	https://pypi.org/project/drf-spectacular-sidecar/"
SRC_URI="https://github.com/tfranzel/drf-spectacular-sidecar/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/django-2.2[${PYTHON_USEDEP}]"
