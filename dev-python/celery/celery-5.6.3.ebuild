# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Distributed Task Queue"
HOMEPAGE="https://docs.celeryq.dev/"
SRC_URI="https://github.com/celery/celery/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"

# Eventually depends on woefully outdated dev-python/docker.
RESTRICT="test"

RDEPEND="
	>=dev-python/billiard-4.2.1[${PYTHON_USEDEP}]
	>=dev-python/kombu-5.6.0[${PYTHON_USEDEP}]
	>=dev-python/vine-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.2[${PYTHON_USEDEP}]
	>=dev-python/click-didyoumean-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/click-repl-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/click-plugins-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
	>=dev-python/tzlocal-5.4.4[${PYTHON_USEDEP}]
"
