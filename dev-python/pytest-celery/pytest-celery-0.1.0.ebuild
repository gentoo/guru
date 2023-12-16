# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10,11} )
inherit distutils-r1

DESCRIPTION="a shim pytest plugin to enable celery.contrib.pytest"
HOMEPAGE="
	https://github.com/celery/pytest-celery
	https://pypi.org/project/pytest-celery/
"
SRC_URI="https://github.com/celery/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/celery-4.4.0[${PYTHON_USEDEP}]"
