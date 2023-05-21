# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_PN="${PN/-python/}"
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for BrowserStack Local"
HOMEPAGE="
	https://github.com/browserstack/browserstack-local-python
	https://pypi.org/project/browserstack-local/
"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/psutil[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

RESTRICT="test" # tests need API key

distutils_enable_tests unittest
