# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{3..12} )

inherit distutils-r1

DESCRIPTION="A fully tested, abstract interface to creating OAuth clients and servers."
HOMEPAGE="https://github.com/joestump/python-oauth2"
SRC_URI="https://github.com/joestump/python-${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S=${WORKDIR}/python-${P}
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/httplib2[${PYTHON_USEDEP}]
dev-python/mock[${PYTHON_USEDEP}]
dev-python/pycodestyle[${PYTHON_USEDEP}]
dev-python/pytest[${PYTHON_USEDEP}]"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	rm -rf "${S}/tests"
	distutils-r1_src_prepare
}
