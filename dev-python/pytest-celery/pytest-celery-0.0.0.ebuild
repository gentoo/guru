# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DISTUTILS_USE_SETUPTOOLS=no
MYPV="${PV/_alpha/a}"
MYP="${PN}-${MYPV}"
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="a shim pytest plugin to enable celery.contrib.pytest"
HOMEPAGE="
	https://github.com/celery/pytest-celery
	https://pypi.org/project/pytest-celery
"
SRC_URI="mirror://pypi/${MYP:0:1}/${PN}/${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/celery-4.4.0[${PYTHON_USEDEP}]"
