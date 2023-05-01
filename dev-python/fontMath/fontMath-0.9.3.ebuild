# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="A collection of objects that implement fast font math"
HOMEPAGE="
	https://pypi.org/project/fontMath/
	https://github.com/robotools/fontMath
"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}" "${PV}" .zip)"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/fonttools-3.32.0[${PYTHON_USEDEP}]"
BDEPEND="
	app-arch/unzip
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
