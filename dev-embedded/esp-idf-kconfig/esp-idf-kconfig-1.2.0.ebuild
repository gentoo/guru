# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1 pypi

DESCRIPTION="Kconfig tooling for esp-idf"
HOMEPAGE="https://github.com/espressif/esp-idf-kconfig"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

RDEPEND="
	dev-python/kconfiglib[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
