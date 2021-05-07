# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MYPV="${PV/_alpha/a}"
MYP="${PN}-${MYPV}"

PYTHON_COMPAT=( python3_{7,8} )
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1

DESCRIPTION="a shim pytest plugin to enable celery.contrib.pytest"
HOMEPAGE="
	https://github.com/celery/pytest-celery
	https://pypi.org/project/pytest-celery
"
SRC_URI="mirror://pypi/${MYP:0:1}/${PN}/${MYP}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/celery-4.4.0[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MYP}"
