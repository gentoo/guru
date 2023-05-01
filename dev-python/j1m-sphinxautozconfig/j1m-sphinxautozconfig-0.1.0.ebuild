# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} pypy3 )
PYPI_NO_NORMALIZE=1
PYPI_PN="${PN/-/\.}"

inherit distutils-r1 pypi

DESCRIPTION="Spinx support for ZConfig"
HOMEPAGE="https://github.com/jimfulton/sphinxautozconfig"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

python_compile() {
	distutils-r1_python_compile
	find "${BUILD_DIR}" -name '*.pth' -delete || die
}
