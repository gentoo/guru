# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1

DESCRIPTION="A python api wrapper and client for Browserstack Screenshots API"
SRC_URI="https://github.com/cmck/pybrowserstack-screenshots/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="
	https://github.com/cmck/pybrowserstack-screenshots
	https://pypi.org/project/pybrowserstack-screenshots/
"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
