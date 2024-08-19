# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="A Python implementation of mustache"
HOMEPAGE="https://github.com/noahmorrison/chevron"

# 0.14.0 was never pushed to GitHub, even master is 1 commit behind.
# For now, pull from pythonhosted.
SRC_URI="https://files.pythonhosted.org/packages/15/1f/ca74b65b19798895d63a6e92874162f44233467c9e7c1ed8afd19016ebe9/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
"

distutils_enable_tests unittest
