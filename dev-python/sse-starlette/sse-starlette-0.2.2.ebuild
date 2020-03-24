# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1

DESCRIPTION="Server Sent Events for Starlette"
HOMEPAGE="
	https://pypi.org/project/sse-starlette/
	https://github.com/sysid/sse-starlette
"
SRC_URI="https://github.com/sysid/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="test? (
	dev-python/black[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
